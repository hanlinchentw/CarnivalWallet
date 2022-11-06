//
//  CallRequest.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/6.
//

import Foundation
import BigInt

struct CallRequest: JsonRpcRequest {
	typealias Response = String
		
	let to: String
	let data: String

	var method: String {
		return "eth_call"
	}
	
	var parameters: Any {
		return [["to": to, "data": data], "latest"]
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
