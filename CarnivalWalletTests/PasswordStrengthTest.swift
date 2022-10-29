//
//  PasswordStrengthTest.swift
//  CarnivalWalletTests
//
//  Created by 陳翰霖 on 2022/10/29.
//

import XCTest

@testable import CarnivalWallet

final class PasswordStrengthTest: XCTestCase {

	func test_strongPassword() {
		// at least one number
		// at least one small/alpha char
		// at least one special char
		// exceed 8 char
		let regex = PasswordStrengthUtils.strongRegex

		let password = "aA@1234567"
		XCTAssertNotNil(try? regex.wholeMatch(in: password))
	}
	
	func test_mediumPassword() {
		// at least one number
		// at least one small/alpha char
		// exceed 8 char
		let regex = PasswordStrengthUtils.mediumRegex

		let password = "a1234567"
		XCTAssertNotNil(try? regex.wholeMatch(in: password))
	}
	
	func test_weakPassword() {
		// exceed 8 char
		let regex = PasswordStrengthUtils.weakRegex

		let password = "a1234567"
		XCTAssertNotNil(try? regex.wholeMatch(in: password))
	}

}
