//
//  GetTransactionByHashProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/1.
//

import Foundation
import APIKit

struct GetTransactionByHashProvider {
	typealias Request = GetTransactionByHashRequest
	
	let txHash: String

	func getTransactionByHash() async throws -> LegacyTransactionObject {
		let request = EtherServiceRequest(
			rpcURL: "https://rpc.ankr.com/eth",
			request: Request.init(txHash: txHash)
		)
		let result = try await Session.send(request)
		return result
	}
}
