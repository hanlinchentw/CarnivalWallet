//
//  KeychainManagerTests.swift
//  CarnivalWalletTests
//
//  Created by 陳翰霖 on 2022/11/27.
//

import XCTest
@testable import CarnivalWallet

final class KeychainManagerTests: XCTestCase {
	func testSetItem() {
		try? KeychainManager.deleteItem(key: "test_password")
		let result = try? KeychainManager.setItem("password", key: "test_password")
		XCTAssertEqual(errSecSuccess, result)
	}
	
	func testGetItem() {
		try? KeychainManager.deleteItem(key: "test_password")
		let result = try? KeychainManager.setItem("password", key: "test_password")
		let item = KeychainManager.getItem(key: "test_password") as? Data

		XCTAssertNotNil(item)

		XCTAssertEqual("password", String(data: item!, encoding: .utf8))
	}
}
