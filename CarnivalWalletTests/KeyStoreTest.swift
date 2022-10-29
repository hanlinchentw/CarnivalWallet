//
//  KeyStoreTest.swift
//  CarnivalWalletTests
//
//  Created by 陳翰霖 on 2022/10/25.
//

import XCTest
import WalletCore

final class KeyStoreTest: XCTestCase {
	var keyDirectory: URL!
	let testMneomonic = "ripple scissors kick mammal hire column oak again sun offer wealth tomorrow wagon turn fatal"

	override func setUp() {
		let fileManager = FileManager.default
		
		keyDirectory = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("KeyStoreTest")
		try? fileManager.removeItem(at: keyDirectory)
		try? fileManager.createDirectory(at: keyDirectory, withIntermediateDirectories: true, attributes: nil)
	}
	
	func testCreateHDWallet() throws {
		let coins = [CoinType.ethereum, .binance, .smartChain]
		let keyStore = try KeyStore(keyDirectory: keyDirectory)
		let newWallet = try keyStore.createWallet(name: "name", password: "password", coins: coins)

		XCTAssertEqual(newWallet.accounts.count, 3)
		XCTAssertEqual(keyStore.wallets.count, 1)
		XCTAssertNoThrow(try newWallet.getAccount(password: "password", coin: .ethereum))
		XCTAssertNoThrow(try newWallet.getAccount(password: "password", coin: .binance))
		XCTAssertNoThrow(try newWallet.getAccount(password: "password", coin: .smartChain))
	}
	
	func testUpdateKey() throws {
			let keyStore = try KeyStore(keyDirectory: keyDirectory)
			let coins = [CoinType.ethereum]
			let wallet = try keyStore.createWallet(name: "name", password: "password", coins: coins)

			try keyStore.update(wallet: wallet, password: "password", newPassword: "testpassword")

			let savedKeyStore = try KeyStore(keyDirectory: keyDirectory)
			let savedWallet = savedKeyStore.wallets.first(where: { $0 == wallet })!

			let data = savedWallet.key.decryptPrivateKey(password: Data("testpassword".utf8))
			let mnemonic = String(data: data!, encoding: .ascii)

			XCTAssertEqual(savedWallet.accounts.count, coins.count)
			XCTAssertNotNil(data)
			XCTAssertNotNil(mnemonic)
			XCTAssert(Mnemonic.isValid(mnemonic: mnemonic!))
			XCTAssertEqual(savedWallet.key.name, "name")
	}
	
	func test_importWallet() throws {
		let password = "testpassword"
		print("keyDirectory >>> \(keyDirectory)")
		print("home >>> \(NSHomeDirectory())")
		let keyStore = try KeyStore(keyDirectory: keyDirectory)
		let wallet = try keyStore.import(mnemonic: testMneomonic, name: "Test Wallet", encryptPassword: password, coins: [.ethereum])
		XCTAssertFalse(keyStore.wallets.isEmpty)
		
		let eth = try wallet.getAccount(password: password, coin: .ethereum, derivation: .default)
		XCTAssertEqual("0xA3Dcd899C0f3832DFDFed9479a9d828c6A4EB2A7".lowercased(), eth.address.lowercased())
	}
}
