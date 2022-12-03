//
//  estimateGasRequest.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/25.
//

import Foundation
import BigInt

struct EstimateGasRequest: JsonRpcRequest {
	typealias Response = String
	
	let from: String
	let to: String
	let value: String
	let data:  String
	
	var method: String {
		return "eth_estimateGas"
	}
	
	var parameters: [Any] {
		return [
			["from":from, "to": to, "value": value, "data": data]
		]
	}

	func response(from resultObject: Any) throws -> Response {
		if let response = resultObject as? [String: Any],
			 let result = response["result"] as? String {
			return result
		} else {
			throw CastError(actualValue: resultObject, expectedType: Response.self)
		}
	}
}
