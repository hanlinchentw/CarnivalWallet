//
//  SendTransactionRequest.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/26.
//

import Foundation
import BigInt

struct SendTransactionRequest: JsonRpcRequest {
	typealias Response = String
	
	let signedTx: String
	
	var method: String {
		return "eth_sendRawTransaction"
	}
	
	var parameters: [Any] {
		return [signedTx, "latest"]
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
