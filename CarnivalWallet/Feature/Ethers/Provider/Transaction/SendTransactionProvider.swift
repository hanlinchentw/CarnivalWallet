//
//  SendTransactionProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/26.
//

import Foundation
import APIKit

struct SendTransactionProvider {
	typealias Request = SendTransactionRequest
	
	let signedTx: String

	func sendTransaction() async throws -> String {
		let request = EtherServiceRequest(
			rpcURL: "https://rpc.ankr.com/eth",
			request: Request.init(signedTx: signedTx)
		)
		let result = try await Session.send(request)
		return result
	}
}
