//
//  GenerateSecretPhraseTest.swift
//  CarnivalWalletTests
//
//  Created by 陳翰霖 on 2022/10/22.
//

import XCTest
import WalletCore

final class GenerateSecretPhraseTest: XCTestCase {
	func testCreateFromMnemonicInvalid() {
		let invalidMneomonic = "THIS IS AN INVALID MNEMONIC"
		XCTAssertFalse(Mnemonic.isValid(mnemonic: invalidMneomonic))
		XCTAssertNil(HDWallet(mnemonic: invalidMneomonic, passphrase: ""))
	}
	
	func test_generateMnemonic_withDifferentLength_12_18_24() {
		let strengthVsLength: [(Int32, Int)] = [
			(128, 12),
			(192, 18),
			(256 , 24)
		]
		for (strength, length) in strengthVsLength {
			let wallet = HDWallet(strength: strength, passphrase: "")
			let nullableMnemonic = wallet?.mnemonic
			guard let mnemonic = nullableMnemonic else {
				return
			}
			let seperateWordList: Array<String> = mnemonic.components(separatedBy: " ")
			XCTAssert(seperateWordList.count == length)
		}
	}
}
