//
//  TokenInfoProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/19.
//

import Foundation
import APIKit

struct GetTokenInfoError: Error {}

enum TokenInfoField: Int, CaseIterable {
	case name
	case symbol
	case decimals
	case balanceOf

	var ERC20ContractABIEncodedData: Data {
		switch self {
		case .name:
			return ERC20Encoder.encodeName()
		case .symbol:
			return ERC20Encoder.encodeSymbol()
		case .decimals:
			return ERC20Encoder.encodeDecimals()
		}
	}
}

struct TokenInfoProvider {
	let contractAddress: String

	func createCallRequest(data: Data) -> EtherServiceRequest<CallRequest> {
		let request = EtherServiceRequest(
			rpcURL: "https://rpc.ankr.com/eth",
			request: CallRequest.init(
				to: contractAddress,
				data: data.hexEncoded
			)
		)
		return request
	}
	
	func getTokenInfo() async throws -> any Token {
		let requests = TokenInfoField.allCases.map { field in
			return (field, createCallRequest(data: field.ERC20ContractABIEncodedData))
		}
		let result = try await withThrowingTaskGroup(of: (TokenInfoField, String).self, returning: [TokenInfoField : String].self) { taskGroup in
			requests.forEach { field, request in
				taskGroup.addTask {
					let result = try await Session.send(request)
					let trimmedResult = String(result.suffix(64)).trimPrefix0().trimSuffix0()
					let parseResult = trimmedResult.parseHex
					return (field, parseResult ?? trimmedResult)
				}
			}
			var results = [TokenInfoField: String]()
			for try await result in taskGroup {
				results[result.0] = result.1
			}
			return results
		}
		guard let name = result[TokenInfoField.name],
					let symbol = result[TokenInfoField.symbol],
					let decimals = result[TokenInfoField.decimals] else {
			throw GetTokenInfoError()
		}
		return TokenImpl(name: name, symbol: symbol, decimals: decimals)
	}
	
}
