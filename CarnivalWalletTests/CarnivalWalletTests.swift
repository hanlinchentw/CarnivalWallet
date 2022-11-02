//
//  CarnivalWalletTests.swift
//  CarnivalWalletTests
//
//  Created by 陳翰霖 on 2022/10/16.
//

import XCTest
import WalletCore
@testable import CarnivalWallet

final class CarnivalWalletTests: XCTestCase {
	func testExample() throws {
		let coin = Coin.testUSDT
		let network = coin.network!.lowercased()
		let address = AnyAddress(string: coin.contractAddress!, coin: .ethereum)!.description
		let url = "https://assets-cdn.trustwallet.com/blockchains/\(network)/assets/0x\(address)/logo.png".toURL
		print("url >>>> \(url)")
	}
}
