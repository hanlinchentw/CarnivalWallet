//
//  RawData.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/23.
//

import Foundation

struct RawData {
	let to: String
	let from: String
	let amount: String
	let dataType: DataType
	let data: String
	var fee: Fee? = nil
}

struct Fee {
	var gasPrice: String
	var gas: String
	let symbol: String
}
