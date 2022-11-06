//
//  TokenBalanceProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/6.
//

import Foundation
import APIKit
import BigInt
import WalletCore
import CryptoKit

protocol TokenBalanceProvider {
	var address: String { get set }
	var contractAddress: String { get set }
	func getBalance() async throws -> String
}


struct GetTokenBalanceProvider: TokenBalanceProvider {
	var address: String
	var contractAddress: String

	func getBalance() async throws -> String {
		let data = ERC20Encoder.encodeBalanceOf(address: address)
		let request = EtherServiceRequest(
			rpcURL: "https://rpc.ankr.com/eth",
			request: CallRequest(
				to: contractAddress,
				data: data.hexEncoded
			)
		)
		return try await Session.send(request)
	}
}
