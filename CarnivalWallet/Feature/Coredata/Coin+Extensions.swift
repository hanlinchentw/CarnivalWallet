//
//  Coin+Extensions.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/5.
//

import Foundation
import CoreData

extension Coin {
	convenience init(
		name: String = "",
		contractAddress: String? = nil,
		balance: String = "0",
		exchangeRate: String = "0",
		symbol: String? = nil,
		network: Network,
		decimals: Int
	) {
		let entity = NSEntityDescription.entity(forEntityName: "Coin", in: .defaultContext)!
		self.init(entity: entity, insertInto: .defaultContext)
		self.name = name
		self.contractAddress = contractAddress
		self.balance = balance
		self.exchangeRate = exchangeRate
		self.symbol = symbol
		self.decimals = decimals.toInt16()
		self.network = network.rawValue
	}
}

extension Coin {
	convenience init(
		tokenInfo: Token,
		balance: String = "0",
		exchangeRate: String = "0",
		network: Network
	) {
		self.init(name: tokenInfo.name, contractAddress: tokenInfo.contractAddress, balance: balance, exchangeRate: exchangeRate, symbol: tokenInfo.symbol, network: network, decimals: tokenInfo.decimals.toInt())
	}
}

extension Coin {
	static func createETH() -> Coin {
		Coin.init(name: "Ethereum", symbol: "ETH", network: Network.ethereum, decimals: 18)
	}
	static func createUSDT() -> Coin {
		Coin.init(name: "Tether USD", contractAddress: "0xdAC17F958D2ee523a2206206994597C13D831ec7", symbol: "USDT", network: Network.ethereum, decimals: 6)
	}
}

extension Coin {
	static var testUSDT: Coin {
		Coin.init(name: "Tether USD", contractAddress: "0xdAC17F958D2ee523a2206206994597C13D831ec7", exchangeRate: "1", symbol: "USDT", network: Network.ethereum, decimals: 6)
	}
	
	static var testETH: Coin {
		Coin.init(name: "Ethereum", balance: "0.5", exchangeRate: "1", symbol: "ETH", network: Network.ethereum, decimals: 18)
	}
}
