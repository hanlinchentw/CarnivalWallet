//
//  TransactionViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/23.
//

import Foundation
import WalletCore

class TransactionViewModel {
	let rawData: RawData
	let coin: Coin
	// MARK: - Lifecycle
	init(coin: Coin, rawData: RawData) {
		self.rawData = rawData
		self.coin = coin
	}
	
	func signTransfer() {
		print("viewModel signTransfer")
		let input = EthereumSigningInput.with {
			$0.chainID = Data(hexString: "01")!
			$0.txMode = .enveloped

			//TODO:  get nonce
			$0.nonce = Data(hexString: "00")!

			// TODO: estimate fee
			$0.gasLimit = Data(hexString: "0130B9")! // 78009
			$0.maxInclusionFeePerGas = Data(hexString: "0077359400")! // 2000000000
			$0.maxFeePerGas = Data(hexString: "00B2D05E00")! // 3000000000

			//TODO: get private key from keystore
			$0.privateKey = Data(hexString: "0x608dcb1742bb3fb7aec002074e3420e4fab7d00cced79ccdac53ed5b27138151")!
			
			switch rawData.dataType {
			case .transfer:
				$0.toAddress = rawData.to
			case .tokenTransfer(let contractAddress):
				$0.toAddress = contractAddress
				$0.transaction = EthereumTransaction.with {
					$0.erc20Transfer = EthereumTransaction.ERC20Transfer.with {
						$0.to = rawData.to
						$0.amount = Data(hexString: rawData.amount.hex)!
					}
				}
			}
		}
		let output: EthereumSigningOutput = AnySigner.sign(input: input, coin: .ethereum)
		let signedTx = output.encoded.hexString
		//TODO: Send signedTx
	}
}
