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
	@Published var gas: String = ""
	@Published var gasPrice: String = ""
	@Published var nonce: String = ""
	
	let rawData: RawData
	let coin: Coin
	
	init(coin: Coin, rawData: RawData) {
		self.rawData = rawData
		self.coin = coin
	}
	
	func getGasFee() async {
		do {
			let from = rawData.from
			let to = rawData.to
			let data = rawData.data
			
			let amountNumber = EtherNumberFormatter.full.number(from: rawData.amount, decimals: coin.decimals.toInt())
			let amount = String(amountNumber!, radix: 16).add0x
			nonce = try await NonceProvider(address: from).getNonce()
			print("\(#function) nonce >>> \(nonce)")
			gasPrice = try await GasPriceProvider().getGasPrice()
			print("\(#function) gasPrice >>> \(gasPrice)")
			let input = EstimateGasInput(from: from, to: to, value: amount, data: data)
			print("estimateGas input >>> \(input)")
			gas = try await EstimateGasProvider(input: input).estimateGas()
			print("\(#function) gas >>> \(gas)")
		} catch {
			print("getGasFee error >>> \(error.localizedDescription)")
		}
	}
	
	func signTransfer() {
		Task {
			do {
				print("viewModel signTransfer")
				guard let password = try? SecureManager.getGenericPassowrd(),
							let privateKey = try? SecureManager.getPrivateKey(password: password) else {
					throw SecureManager.PasswordRetrivedError()
				}
				let input = EthereumSigningInput.with {
					$0.chainID = Data(hexString: "01")!
					$0.nonce = Data(hexString: self.nonce)!
					$0.gasLimit = Data(hexString: self.gas)!
					$0.gasPrice = Data(hexString: self.gasPrice)!
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
