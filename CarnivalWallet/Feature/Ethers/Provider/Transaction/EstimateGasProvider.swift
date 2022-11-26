//
//  EstimateGasProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/25.
//

import Foundation
import APIKit

struct EstimateGasInput {
	let from: String
	let to: String
	let value: String
	let data:  String

}
struct EstimateGasProvider {
	typealias Request = EstimateGasRequest
	let input: EstimateGasInput

	func estimateGas() async throws -> String {
		let request = EtherServiceRequest(
			rpcURL: "https://rpc.ankr.com/eth",
			request: Request.init(from: input.from, to: input.to, value: input.value, data: input.data)
		)
		let result = try await Session.send(request)
		print("result >>> \(result)")
		return result
	}
}
