//
//  TokenBalanceProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/6.
//

import Foundation
import APIKit
import BigInt

struct TokenBalanceProvider: BalanceProvider {
	typealias Request = CallRequest

	var address: String
	var contractAddress: String?

	func getBalance() async throws -> String {
		let data = ERC20Encoder.encodeBalanceOf(address: address)
		let request = EtherServiceRequest(
			rpcURL: "https://rpc.ankr.com/eth",
			request: Request.init(
				to: contractAddress!,
				data: data.hexEncoded
			)
		)
		let result = try await Session.send(request)
		let value = try ObjectUtils.checkNotNil(BigInt(result.drop0x, radix: 16), message: "getBalance result to BigInt Failed.")
		return String(value)
	}
}
