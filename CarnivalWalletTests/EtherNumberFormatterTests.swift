//
//  EtherNumberFormatterTests.swift
//  CarnivalWalletTests
//
//  Created by 陳翰霖 on 2022/11/10.
//

import XCTest
import BigInt
@testable import CarnivalWallet

final class EtherNumberFormatterTests: XCTestCase {
	func test_string() {
		let test1 = EtherNumberFormatter.full.string(from: BigInt("87654321"), decimals: 6)
		XCTAssertEqual("87.654321", test1)
		
		let test2 = EtherNumberFormatter.full.string(from: BigInt("876543210"), decimals: 6)
		XCTAssertEqual("876.54321", test2)
		
		let test3 = EtherNumberFormatter.full.string(from: BigInt("87654321000000"), decimals: 6)
		XCTAssertEqual("87654321", test3)
		
		let test4 = Formatter.withSeparator.string(from: test3.toDouble() as NSNumber)
		XCTAssertEqual("87,654,321", test4)
	}
}
