//
//  JsonRpcRequest.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/6.
//

import Foundation

protocol JsonRpcRequest {
	associatedtype Response
	var method: String { get }
	var parameters: [Any] { get }
	func response(from resultObject: Any) throws -> Response
	var requestBody: [String: Any] { get }
}

extension JsonRpcRequest {
	var requestBody: [String: Any] {
		[
			"jsonrpc": "2.0",
			"id"     : 1,
			"method" : method,
			"params" : parameters
		]
	}
}
