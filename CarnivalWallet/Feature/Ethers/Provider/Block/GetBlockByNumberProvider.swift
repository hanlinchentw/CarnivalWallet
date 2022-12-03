//
//  GetBlockByNumberProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/2.
//

import Foundation
import APIKit

struct GetBlockByNumberProvider {
	typealias Request = GetBlockNumberReqeust

	let blockNumber: String
	
	func getBlockByNumber() async throws -> String {
		let request = EtherServiceRequest(
			rpcURL: "https://rpc.ankr.com/eth",
			request: Request.init(blockNumber: blockNumber)
		)
		let result = try await Session.send(request)
		return result
	}
}
