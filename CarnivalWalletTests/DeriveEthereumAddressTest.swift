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
		let zpub = self.testWallet.getExtendedPublicKey(purpose: .bip44, coin: .ethereum, version: .zpub)
		XCTAssertEqual("zpub6qXwnusRFJk3csMsfXkgdi3Qe29TD6YQ6cVxKKDEGYjmRkdTiSnrCNFo6K6gHks4pWE1osATNUQnLC3C2e9h8qa9pHw3i13ovXrtjk3AWE9", zpub)
	}
	
	func test_DeriveEthereumAddress_fromPubKey() {
		let eth = CoinType.ethereum
		let zpub = "zpub6qXwnusRFJk3csMsfXkgdi3Qe29TD6YQ6cVxKKDEGYjmRkdTiSnrCNFo6K6gHks4pWE1osATNUQnLC3C2e9h8qa9pHw3i13ovXrtjk3AWE9"

		let path = DerivationPath(purpose: eth.purpose, coin: eth.slip44Id, account: 0, change: 0, address: 0)
		let pubkey = HDWallet.getPublicKeyFromExtended(extended: zpub, coin: eth, derivationPath: path.description)!
		let address = eth.deriveAddressFromPublicKey(publicKey: pubkey)
		XCTAssertEqual("0xA3Dcd899C0f3832DFDFed9479a9d828c6A4EB2A7".lowercased(), address.lowercased())
	}
}
