//
//  CoinBalanceProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/9.
//

import Foundation
import APIKit

struct BalanceProviderImpl: BalanceProvider {
	typealias Request = BalanceRequest

	var address: String

	func getBalance() async throws -> String {
		let request = EtherServiceRequest(
			rpcURL: "https://rpc.ankr.com/eth", // TODO: should be injected
			request: Request.init(address: address)
		)
		let result = try await Session.send(request)
		print("\(#function) address: \(address)")
		print("result >>> \(result)")
		return result
	}
}
