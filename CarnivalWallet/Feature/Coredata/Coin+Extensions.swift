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
		contractAddress: String? = nil,
		balance: String = "0",
		exchangeRate: String = "0",
		symbol: String? = nil,
		network: Network,
		decimals: Int
	) {
		let entity = NSEntityDescription.entity(forEntityName: "Coin", in: .defaultContext)!
		self.init(entity: entity, insertInto: .defaultContext)
		self.contractAddress = contractAddress
		self.balance = balance
		self.exchangeRate = exchangeRate
		self.symbol = symbol
		self.decimals = decimals.toInt16()
		self.network = network.rawValue
	}
}

extension Coin {
	static func createETH() -> Coin {
		Coin.init(symbol: "ETH", network: Network.ethereum, decimals: 18)
	}
	static func createUSDT() -> Coin {
		Coin.init(contractAddress: "0xdAC17F958D2ee523a2206206994597C13D831ec7", symbol: "USDT", network: Network.ethereum, decimals: 6)
	}
}

extension Coin {
	static var testUSDT: Coin {
		Coin.init(contractAddress: "0xdAC17F958D2ee523a2206206994597C13D831ec7", exchangeRate: "1", symbol: "USDT", network: Network.ethereum, decimals: 6)
	}
	
	static var testETH: Coin {
		Coin.init(balance: "0.5", exchangeRate: "1", symbol: "ETH", network: Network.ethereum, decimals: 18)
	}
}
