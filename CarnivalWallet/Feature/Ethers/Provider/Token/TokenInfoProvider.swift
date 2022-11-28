//
//  TokenInfoProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/19.
//

import Foundation
import APIKit

struct TokenInfoProvider {
	let contractAddress: String

	func createCallRequest(data: Data) -> EtherServiceRequest<CallRequest> {
		let request = EtherServiceRequest(
			rpcURL: "https://rpc.ankr.com/eth",
			request: CallRequest.init(
				to: contractAddress,
				data: data.hexString.add0x
			)
		)
		return request
	}
	
	func getTokenInfo() async throws -> any Token {
		let requests = [ERC20ABIFunction.name, ERC20ABIFunction.symbol, ERC20ABIFunction.decimals].map { field in
			return (field, createCallRequest(data: field.data))
		}

		let result = try await withThrowingTaskGroup(of: (ERC20ABIFunction, String).self, returning: [ERC20ABIFunction : String].self) { taskGroup in
			requests.forEach { field, request in
				taskGroup.addTask {
					let result = try await Session.send(request)
					guard let parseResult = field.parse(rawData: result) else {
						throw GetTokenInfoError()
					}
					return (field, parseResult)
				}
			}
			var results = [ERC20ABIFunction: String]()
			for try await result in taskGroup {
				results[result.0] = result.1
			}
			return results
		}
		
		guard let name = result[ERC20ABIFunction.name],
					let symbol = result[ERC20ABIFunction.symbol],
					let decimals = result[ERC20ABIFunction.decimals] else {
			throw GetTokenInfoError()
		}
		return TokenImpl(contractAddress: contractAddress, name: name, symbol: symbol, decimals: decimals)
	}
	
	func getDecimals() async throws -> String {
		let request = createCallRequest(data: ERC20ABIFunction.decimals.data)
		let result = try await Session.send(request)
		return result
	}
}

extension TokenInfoProvider {
	struct GetTokenInfoError: Error {}
}
