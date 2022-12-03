//
//  GetTransactionByHashRequest.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/1.
//

import Foundation

struct LegacyTransactionObject: Decodable{
	var blockNumber: String
	var from: String
	var to: String
	var type: String
	var nonce: String
	var value: String
	var input: String
	let gas: String
	let gasPrice: String
}
struct GetTransactionByHashRequest: JsonRpcRequest {
	typealias Response = LegacyTransactionObject
	
	let txHash: String
	
	var method: String {
		return "eth_getTransactionByHash"
	}
	
	var parameters: [Any] {
		return [txHash]
	}
	
	func response(from resultObject: Any) throws -> Response {
		if let response = resultObject as? [String: Any],
			 let result = response["result"] as? [String: Any] {
			if let legacyObject = result.object(LegacyTransactionObject.self) {
				return legacyObject
			}
		}
		throw CastError(actualValue: resultObject, expectedType: Response.self)
	}
}
