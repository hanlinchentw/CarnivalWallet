//
//  NonceProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/25.
//

import Foundation
import APIKit

struct NonceProvider {
	typealias Request = NonceRequest
	
	let address: String

	func getNonce() async throws -> String {
		let request = EtherServiceRequest(
			rpcURL: "https://rpc.ankr.com/eth",
			request: Request.init(address: address)
		)
		let result = try await Session.send(request)
		return result
	}
}
