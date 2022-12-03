//
//  GasPriceRequest.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/25.
//

import Foundation
import BigInt

struct GasPriceRequest: JsonRpcRequest {
	typealias Response = String

	var method: String {
		return "eth_gasPrice"
	}
	
	var parameters: [Any] {
		return []
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
