//
//  TransactionInfoProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/28.
//

import Foundation
import BigInt

struct TransactionInfoProvider {
	struct TransactionInfo {
		let nonce: String
		let gas: String
		let gasPrice: String
	}
	
	let from: String
	let to: String
	let data: String
	let amount: String
	let contractAddress: String?

	func getTransactionInfo() async throws -> TransactionInfo {
		let nonce = try await NonceProvider(address: from).getNonce()
		
		let gasPrice = try await GasPriceProvider().getGasPrice()

		var amountNumber = BigInt()
		if let contractAddress {
			let decimals = try await TokenInfoProvider(contractAddress: contractAddress).getDecimals()
			amountNumber = EtherNumberFormatter.full.number(from: amount, decimals: decimals.toInt())!
		} else {
			amountNumber = EtherNumberFormatter.full.number(from: amount, decimals: 18)!
		}

		let amount = String(amountNumber, radix: 16).add0x
		let input = EstimateGasInput(from: from, to: to, value: amount, data: data)
		let gas = try await EstimateGasProvider(input: input).estimateGas()
		
		return .init(nonce: nonce, gas: gas, gasPrice: gasPrice)
	}
	
	func getFee() async throws -> String {
		let feeInfo = try await self.getTransactionInfo()
		return calculateFee(feeInfo: feeInfo)
	}
	
	func calculateFee(feeInfo: TransactionInfo) -> String {
		let gasBigInt = BigInt(feeInfo.gas)!
		let gasPriceBigInt = BigInt(feeInfo.gasPrice)!
		let fee = gasBigInt * gasPriceBigInt
		return EtherNumberFormatter.full.string(from: fee)
	}
}


