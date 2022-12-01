//
//  GetTransactionByHashRequest.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/1.
//

import Foundation

protocol TransactionObject {
	var type: String { get set }
	var nonce: String { get set }
	var value: String { get set }
	var input: String { get set }
}

struct LegacyTransactionObject: TransactionObject {
	var type: String
	var nonce: String
	var value: String
	var input: String

	let gas: String
	let gasPrice: String
}

struct EIP1559TransactionObject: TransactionObject {
	var type: String
	var nonce: String
	var value: String
	var input: String

	let maxFeePerGas: String
	let maxPriorityFeePerGas: String
}

struct GetTransactionByHashRequest: JsonRpcRequest {
	typealias Response = TransactionObject
	
	let txHash: String

	var method: String {
		return "eth_getTransactionByHash"
	}
	
	var parameters: [Any] {
		return [txHash]
	}

	func response(from resultObject: Any) throws -> Response {
		if let response = resultObject as? [String: Any] {
			if let result = response["result"] as? LegacyTransactionObject {
				return result
			}
			if let result = response["result"] as? EIP1559TransactionObject {
				return result
			}
		}
		throw CastError(actualValue: resultObject, expectedType: (any Response).self)
	}
}
