//
//  TransactionViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/23.
//

import Foundation
import WalletCore
import BigInt

class TransactionViewModel {
	@Published var coinIconData: Data?
//	@Published var gas: String = ""
//	@Published var gasPrice: String = ""
	@Published var nonce: String = ""
	
	@Published var rawData: RawData
	var coin: Coin
	
	init(coin: Coin, rawData: RawData) {
		self.rawData = rawData
		self.coin = coin
	}
	
	func getGasFee() async {
		do {
			let from = rawData.from
			let to = rawData.to
			let data = rawData.data

			nonce = try await NonceProvider(address: from).getNonce()
			
			let gasPrice = try await GasPriceProvider().getGasPrice()
			let amountNumber = EtherNumberFormatter.full.number(from: rawData.amount, decimals: coin.decimals.toInt())
			let amount = String(amountNumber!, radix: 16).add0x
			let input = EstimateGasInput(from: from, to: to, value: amount, data: data)
			let gas = try await EstimateGasProvider(input: input).estimateGas()
			
			DispatchQueue.main.async {
				let fee: Fee = .init(gasPrice: gasPrice, gas: gas, symbol: "ETH")
				self.rawData.fee = fee
				print(">>> getGasFee.fee=\(fee)")
			}
		} catch {
			print("getGasFee error >>> \(error.localizedDescription)")
		}
	}
	
	func signTransfer() {
		Task {
			do {
				guard let password = try? SecureManager.getGenericPassowrd(),
							let privateKey = try? SecureManager.getPrivateKey(password: password) else {
					throw SecureManager.PasswordRetrivedError()
				}
				
				guard let fee = rawData.fee else {
					return
				}
				let input = EthereumSigningInput.with {
					$0.chainID = Data(hexString: "01")!
					$0.nonce = Data(hexString: self.nonce)!
					$0.gasLimit = Data(hexString: fee.gas)!
					$0.gasPrice = Data(hexString: fee.gasPrice)!
					$0.privateKey = privateKey
					$0.toAddress = rawData.to
					$0.transaction = EthereumTransaction.with {
						if rawData.dataType == .tokenTransfer {
							$0.erc20Transfer = EthereumTransaction.ERC20Transfer.with {
								$0.to = rawData.to
								$0.amount = Data(hexString: rawData.amount.hex)!
							}
						} else {
							$0.transfer = EthereumTransaction.Transfer.with({
								$0.data = Data(hexString: rawData.data.hex)!
								$0.amount = Data(hexString: rawData.amount.hex)!
							})
						}
					}
				}
				let output: EthereumSigningOutput = AnySigner.sign(input: input, coin: .ethereum)
				let signedTx = output.encoded.hexString
				let txId = try await SendTransactionProvider(signedTx: signedTx).sendTransaction()
				print("txId >>> \(txId)")
			} catch {
				
			}
		}
	}
}

extension TransactionViewModel {
	func getIconURL(network: String, contractAddress: String) -> URL {
		let address = AnyAddress(string: contractAddress, coin: .ethereum)!.description
		let url = "https://assets-cdn.trustwallet.com/blockchains/\(network)/assets/\(address)/logo.png".toURL
		return url
	}

	func loadCoinIcon() {
		Task {
			if let contractAddress = coin.contractAddress {
				let url = getIconURL(network: Network.ethereum.rawValue.lowercased(), contractAddress: contractAddress)
				self.coinIconData = try? await URLSession.shared.data(from: url).0
			} else {
				self.coinIconData = UIImage(named: "ethereum")?.pngData()
			}
		}
	}
}
