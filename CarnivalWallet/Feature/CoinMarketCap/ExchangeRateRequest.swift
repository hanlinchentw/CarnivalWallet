//
//  ExchangeRateRequest.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/3.
//

import Foundation
import APIKit

struct ExchangeRateRequest: APIKit.Request {
	typealias Response = Double
	
	static let key = "e864647a-4b65-4409-821d-9ee406891df1"
	
	var symbol: String
	
	var baseURL: URL {
		"https://pro-api.coinmarketcap.com/v2".toURL
	}
	
	var path: String {
		"/cryptocurrency/quotes/latest"
	}
	
	var method: APIKit.HTTPMethod {
		.get
	}
	
	var headerFields: [String : String] {
		["X-CMC_PRO_API_KEY": ExchangeRateRequest.key]
	}
	
	var parameters: Any? {
		["symbol": symbol]
	}
	
	func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
		if let response = object as? [String: Any],
			 let result = response["data"] as? [String: Any],
			 let coin = result[symbol] as? [Any],
			 let coinData = coin[0] as? [String: Any],
			 let exchangeRate = coinData.object(ExchangeRate.self) {
			return exchangeRate.quote.usd.price
		}
		
		throw CastError(actualValue: object, expectedType: Response.self)
	}
}
