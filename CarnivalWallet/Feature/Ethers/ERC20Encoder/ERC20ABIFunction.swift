//
//  ERC20ABIFunction.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/19.
//

import Foundation
import BigInt
import APIKit

enum ERC20ABIFunction {
	case name
	case symbol
	case decimals
	case balanceOf(address: String)
	
	var data: Data {
		switch self {
		case .name:
			return ERC20Encoder.encodeName()
		case .symbol:
			return ERC20Encoder.encodeSymbol()
		case .decimals:
			return ERC20Encoder.encodeDecimals()
		case .balanceOf(let address):
			return ERC20Encoder.encodeBalanceOf(address: address)
		}
	}
	
	func parse(rawData: String) -> String? {
		switch self {
		case .name, .symbol:
			let trimmedResult = String(rawData.suffix(64)).trimPrefix0().trimSuffix0()
			return trimmedResult.parseHex
		case .decimals, .balanceOf(_):
			return BigInt(rawData.drop0x, radix: 16)?.description
		}
	}
	
	@Sendable
	func responseTask(contractAddress: String) -> Task<String, any Error> {
		return Task {
			let result = try await Session.send(ERC20ABIFunction.createCallRequest(contractAddress: contractAddress, data: self.data))
			guard let parseResult = self.parse(rawData: result) else {
				throw ParseError(parseValue: result)
			}
			return parseResult
		}
	}
}

extension ERC20ABIFunction: Hashable {}

extension ERC20ABIFunction {
	static func createCallRequest(contractAddress: String, data: Data) -> EtherServiceRequest<CallRequest> {
		let request = EtherServiceRequest(
			rpcURL: "https://rpc.ankr.com/eth",
			request: CallRequest.init(
				to: contractAddress,
				data: data.hexEncoded
			)
		)
		return request
	}
}
