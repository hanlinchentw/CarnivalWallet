//
//  GenerateSecretPhraseTest.swift
//  CarnivalWalletTests
//
//  Created by 陳翰霖 on 2022/10/22.
//

import XCTest
import web3swift

final class GenerateSecretPhraseTest: XCTestCase {
	func testCreateFromMnemonicInvalid() {
		let invalidMneomonic = "THIS IS AN INVALID MNEMONIC"
		XCTAssertNil(try? BIP32Keystore(mnemonics: invalidMneomonic))
	}
	
	func test_generateMnemonic_withDifferentLength_12_18_24() {
		let strengthVsLength: [(Int, Int)] = [
			(128, 12),
			(192, 18),
			(256 , 24)
		]
		for (strength, length) in strengthVsLength {
			let nullableMnemonic = try? BIP39.generateMnemonics(bitsOfEntropy: strength, language: .english)
			guard let mnemonic = nullableMnemonic else {
				return
			}
			let seperateWordList: Array<String> = mnemonic.components(separatedBy: " ")
			XCTAssert(seperateWordList.count == length)
		}
	}
}
