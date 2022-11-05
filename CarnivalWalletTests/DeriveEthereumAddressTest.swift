//
//  DeriveEthereumAddressTest.swift
//  CarnivalWalletTests
//
//  Created by 陳翰霖 on 2022/10/22.
//

import XCTest
import WalletCore

final class DeriveEthereumAddressTest: XCTestCase {
	var testWallet: HDWallet!
	let testMneomonic = "ripple scissors kick mammal hire column oak again sun offer wealth tomorrow wagon turn fatal"

	override func setUp() {
		self.testWallet =  HDWallet(mnemonic: testMneomonic, passphrase: "")!
	}
	
	func test_DeriveEthereumAddress_fromWallet() {
		let address = self.testWallet.getAddressForCoin(coin: .ethereum)
		XCTAssertNotNil(address)
		XCTAssertEqual("0xA3Dcd899C0f3832DFDFed9479a9d828c6A4EB2A7".lowercased(), address.lowercased())
	}

	func test_DerivePubKey() {
		let xpub = self.testWallet.getExtendedPublicKey(purpose: .bip44, coin: .ethereum, version: .xpub)
		XCTAssertEqual("xpub6BsRBaXawwf5vGydzpBSDXrQJ5rZKrZQGPTWkXRTWXz1KZ11D8TixEwX3uBWHwZE1DzQJuyLT9hgZcp4bFKfYNCx5cYCYBQqP5jbxcVQumc", xpub)
	}
	
	func test_DeriveEthereumAddress_fromPubKey() {
		let eth = CoinType.ethereum
		let xpub = self.testWallet.getExtendedPublicKey(purpose: .bip44, coin: eth, version: .xpub)

		let path = DerivationPath(purpose: .bip44, coin: eth.slip44Id, account: 0, change: 0, address: 0)
		let pubkey = HDWallet.getPublicKeyFromExtended(extended: xpub, coin: eth, derivationPath: path.description)!
		let address = eth.deriveAddressFromPublicKey(publicKey: pubkey)
		XCTAssertEqual("0xA3Dcd899C0f3832DFDFed9479a9d828c6A4EB2A7".lowercased(), address.lowercased())
	}
}
