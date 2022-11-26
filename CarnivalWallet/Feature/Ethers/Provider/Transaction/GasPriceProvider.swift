//
//  GasPriceProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/25.
//

import Foundation
import APIKit

struct GasPriceProvider {
	typealias Request = GasPriceRequest

	func getGasPrice() async throws -> String {
		let request = EtherServiceRequest(
			rpcURL: "https://rpc.ankr.com/eth",
			request: Request.init()
		)
		let result = try await Session.send(request)
		print("result >>> \(result)")
		return result
	}
}
