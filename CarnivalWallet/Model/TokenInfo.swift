//
//  TokenInfo.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/19.
//

import Foundation

protocol Token {
	var contractAddress: String { get }
	var name: String { get }
	var symbol: String { get }
	var decimals: String { get }
}

struct TokenImpl: Token {
	var contractAddress: String
	var name: String
	var symbol: String
	var decimals: String
}
