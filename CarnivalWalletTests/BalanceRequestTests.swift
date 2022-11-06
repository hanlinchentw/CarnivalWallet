//
//  BalanceRequestTests.swift
//  CarnivalWalletTests
//
//  Created by 陳翰霖 on 2022/11/5.
//

import XCTest
import APIKit
import WalletCore

@testable import CarnivalWallet

final class BalanceRequestTests: XCTestCase {
	func testExample() async throws {
		let provider = GetBalanceProvider(address: "0x1e200594af3E23462a035076F3499295734a3c1d")
		let balance = try await provider.getBalance()
		print("balance >>> \(balance)")
	}
	
	func testTokenExample() async throws {
		let provider = GetTokenBalanceProvider(
			address: "0x1e200594af3E23462a035076F3499295734a3c1d",
			contractAddress: "0xdAC17F958D2ee523a2206206994597C13D831ec7"
		)
		let balance = try await provider.getBalance()
		print("balance >>> \(balance)")
	}
}
