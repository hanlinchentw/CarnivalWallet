//
//  EtherServiceRequest.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/5.
//


import Foundation
import APIKit

struct EtherServiceRequest<T: JsonRpcRequest>: APIKit.Request {
	let request: T
	let rpcURL: String
	typealias Response = T.Response
	
	init(rpcURL: String, request: T) {
		self.rpcURL = rpcURL
		self.request = request
	}
	
	var baseURL: URL {
		return rpcURL.toURL
	}
	
	var method: HTTPMethod {
		return .post
	}
	
	var path: String {
		return "/"
	}
	
	var parameters: Any? {
		return request.requestBody
	}
	
	func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
		return try request.response(from: object)
	}
}
