//
//  TokenSymbolProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/19.
//

import Foundation
import APIKit

protocol SymbolProvider {
	var contractAddress: String { get }
	func getSymbol() async throws -> String
}

class TokenSymbolProvider: SymbolProvider {
	typealias Request = CallRequest

	var contractAddress: String
	
	init(contractAddress: String) {
		self.contractAddress = contractAddress
	}

	func getSymbol() async throws -> String {
		let data = ERC20Encoder.encodeSymbol()
		let request = EtherServiceRequest(
			rpcURL: "https://rpc.ankr.com/eth",
			request: Request.init(
				to: contractAddress,
				data: data.hexEncoded
			)
		)
		return try await Session.send(request)
	}
}
