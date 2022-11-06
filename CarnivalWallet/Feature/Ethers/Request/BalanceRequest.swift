//
//  BalanceRequest.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/5.
//

import Foundation
import BigInt

struct BalanceRequest: JsonRpcRequest {
	typealias Response = String
	
	let address: String
	
	var method: String {
		return "eth_getBalance"
	}
	
	var parameters: Any {
		return [address, "latest"]
	}

	func response(from resultObject: Any) throws -> Response {
		if let response = resultObject as? [String: Any],
			 let result = response["result"] as? String,
			 let value = BigInt(result.drop0x, radix: 16) {
			return String(value)
		} else {
			throw CastError(actualValue: resultObject, expectedType: Response.self)
		}
	}
}
