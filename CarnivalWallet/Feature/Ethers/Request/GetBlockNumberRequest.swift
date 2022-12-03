//
//  GetBlockNumberRequest.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/1.
//

import Foundation

struct GetBlockNumberReqeust: JsonRpcRequest {
	typealias Response = String
	
	let blockNumber: String

	var method: String {
		"eth_getBlockByNumber"
	}
	
	var parameters: [Any] {
		[blockNumber, true]
	}
	
	func response(from resultObject: Any) throws -> Response {
		if let response = resultObject as? [String: Any],
			 let result = response["result"] as? [String: Any],
			 let timestamp = result["timestamp"] as? String {
			return timestamp
		}
		throw CastError(actualValue: resultObject, expectedType: Response.self)
	}
}
