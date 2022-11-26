//
//  CarnivalWalletTests.swift
//  CarnivalWalletTests
//
//  Created by 陳翰霖 on 2022/10/16.
//

import XCTest
import WalletCore
import BigInt
@testable import CarnivalWallet

final class CarnivalWalletTests: XCTestCase {
	func testExample() throws {
		let coin = Coin.testUSDT
		let network = coin.network!.lowercased()
		let address = AnyAddress(string: coin.contractAddress!, coin: .ethereum)!.description
		let url = "https://assets-cdn.trustwallet.com/blockchains/\(network)/assets/0x\(address)/logo.png".toURL
		print("url >>>> \(url)")
	}
	
	func test_2() {
		let valueString = "99160697"
		let value = BigInt(99160697)
		let hexValue = "0" + String(value, radix: 16)
		let encodedData = ERC20Encoder.encodeTransfer(to: "0x1e200594af3E23462a035076F3499295734a3c1d", value: hexValue.add0x)
		print("encodedData >>> \(encodedData.hexString)")
	}
	
	func test_3() {
		let amount = "0"
		let number = EtherNumberFormatter.full.number(from: amount, decimals: 18)
		let string = number?.description
		let hexEncoded = String(number!, radix: 16).add0x
		
		XCTAssertNotNil(number)
		XCTAssertNotNil(string)
		XCTAssertNotNil(hexEncoded)
		XCTAssertEqual(0, number!)
		XCTAssertEqual("0", string!)
		XCTAssertEqual("0x0", hexEncoded)
	}
	
	func test_4() {
		let dataString = "0xa9059cbb0000000000000000000000001e200594af3e23462a035076f3499295734a3c1d0000000000000000000000000000000000000000000000000000000000000000"
		let (address, amount) = ERC20Decoder.decodeTokenTransfer(data: dataString)
		XCTAssertEqual("0x1e200594af3e23462a035076f3499295734a3c1d", address)
		XCTAssertEqual("0", amount)
	}
}

