//
//  ERC20Decoder.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/26.
//

import Foundation

class ERC20Decoder {
	static func decodeTokenTransfer(data: String) -> (String, String) {
		let dataString = "0xa9059cbb0000000000000000000000001e200594af3e23462a035076f3499295734a3c1d0000000000000000000000000000000000000000000000000000000000000000"
		let addressPart = dataString.substring(with: 10 ..< 74).trimPrefix0().add0x
		let amountPart = dataString.substring(with: 74 ..< dataString.count).trimPrefix0()
		if amountPart == "" {
			return (addressPart, "0")
		}
		return (addressPart, amountPart)
	}
}
