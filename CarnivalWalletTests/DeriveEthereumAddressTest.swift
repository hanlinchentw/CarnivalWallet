//
//  DeriveEthereumAddressTest.swift
//  CarnivalWalletTests
//
//  Created by 陳翰霖 on 2022/10/22.
//

import XCTest
import web3swift

final class DeriveEthereumAddressTest: XCTestCase {
	var testWallet: BIP32Keystore!
	
	override func setUp() {
		self.testWallet = try! BIP32Keystore(mnemonics: Mock_HDWallet.testMneomonic)
	}
	
	func testDeriveEthereum_fromWallet() {
		let wallet = testWallet
		let addresses = wallet?.addresses?[0]
		XCTAssertNotNil(addresses)
		XCTAssertEqual("0xA3Dcd899C0f3832DFDFed9479a9d828c6A4EB2A7".lowercased(), addresses!.address.lowercased())
	}
	
	func test_addNewAccount() {
		let wallet = testWallet
		try? wallet?.createNewChildAccount(password: "web3swift")
		XCTAssertNotNil(wallet)
		let addresses = wallet?.addresses!.map { $0.address }
		XCTAssertEqual("0xA3Dcd899C0f3832DFDFed9479a9d828c6A4EB2A7".lowercased(), addresses![0].lowercased())
		XCTAssertEqual("0xd6c3112a8db4991a7359018f15e501dfee316d59".lowercased(), addresses![1].lowercased())
	}
}
