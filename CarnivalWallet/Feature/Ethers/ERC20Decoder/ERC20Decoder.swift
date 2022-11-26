//
//  ERC20Decoder.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/26.
//

import Foundation

class ERC20Decoder {
	static func decodeTokenTransfer(data: String) -> (String, String) {
		let addressPart = data.substring(with: 10 ..< 74).trimPrefix0().add0x
		let amountPart = data.substring(with: 74 ..< data.count).trimPrefix0()
		if amountPart == "" {
			return (addressPart, "0")
		}
		return (addressPart, amountPart)
	}
}
