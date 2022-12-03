//
//  ExchangeRateProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/3.
//

import Foundation
import APIKit

struct ExchangeRateProvider {
	let symbol: String

	func getExchangeRate() async throws -> Double {
		let request = ExchangeRateRequest(symbol: symbol)
		return try await Session.send(request)
	}
}
