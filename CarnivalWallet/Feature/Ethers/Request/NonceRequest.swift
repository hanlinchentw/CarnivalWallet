//
//  NonceRequest.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/25.
//

import Foundation
import BigInt

struct NonceRequest: JsonRpcRequest {
	typealias Response = String
	
	let address: String
	
	var method: String {
		return "eth_getTransactionCount"
	}
	
	var parameters: [Any] {
		return [address, "latest"]
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
