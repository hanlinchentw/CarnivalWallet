//
//  String+Extensions.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import Foundation
import BigInt

extension String {
	var toURL: URL {
		URL(string: self)!
	}
	
	func toHex(decimals: Int = 0) -> String {
		let number = EtherNumberFormatter.full.number(from: self, decimals: decimals)
		var hexEncoded = String(number!, radix: 16)
		if hexEncoded.count % 2 != 0 {
			hexEncoded = "0" + hexEncoded
		}
		return hexEncoded.add0x
	}
}
