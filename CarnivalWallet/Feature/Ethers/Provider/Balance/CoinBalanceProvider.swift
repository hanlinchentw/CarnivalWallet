//
//  CoinBalanceProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/9.
//

import Foundation
import APIKit

struct CoinBalanceProvider: BalanceProvider {
	typealias Request = BalanceRequest

	var address: String
	var contractAddress: String?

	func getBalance() async throws -> String {
		let request = EtherServiceRequest(
			rpcURL: "https://rpc.ankr.com/eth", // TODO: should be injected
			request: Request.init(address: address)
		)
		return try await Session.send(request)
	}
}
