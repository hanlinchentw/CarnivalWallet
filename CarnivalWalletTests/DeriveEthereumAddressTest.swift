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
		//		let privateKey = Mock_HDWallet.testWallet.getKeyForCoin(coin: ethereum)
		let addresses = wallet?.addresses?[0]
		XCTAssertNotNil(addresses)
		XCTAssertEqual("0xA3Dcd899C0f3832DFDFed9479a9d828c6A4EB2A7".lowercased(), addresses!.address.lowercased())
	}
}
