//
//  BalanceProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/6.
//

import Foundation
import APIKit
import BigInt
import WalletCore

protocol BalanceProvider {
	var address: String { get set }
	func getBalance() async throws -> String
}

struct GetBalanceProvider: BalanceProvider {
	var address: String
	func getBalance() async throws -> String {
		let request = EtherServiceRequest(
			rpcURL: "https://rpc.ankr.com/eth", // TODO: should be injected
			request: BalanceRequest(address: address)
		)
		return try await Session.send(request)
	}
}
