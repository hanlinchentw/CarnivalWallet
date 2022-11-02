//
//  AccountEntity+Extensions.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/31.
//

import Foundation
import CoreData

extension AccountEntity {
	convenience init(name: String, address: String, extendedKey: String? = nil) {
		let entity = NSEntityDescription.entity(forEntityName: "AccountEntity", in: .defaultContext)!
		self.init(entity: entity, insertInto: .defaultContext)
		self.name = name
		self.address = address
		self.extendedKey = extendedKey
		self.addToCoin(.init(symbol: "ETH", network: .ethereum))
	}
}

extension AccountEntity {
	static var testEthAccountEntity: AccountEntity {
		let entity = AccountEntity.init(name: "Wallet 1", address: "0x1e200594af3E23462a035076F3499295734a3c1d")
		entity.addToCoin(Coin.testUSDT)
		return entity
	}
}

extension Coin {
	convenience init(contractAddress: String? = nil, balance: String = "0", exchangeRate: String = "0", symbol: String? = nil, network: Network? = nil) {
		let entity = NSEntityDescription.entity(forEntityName: "Coin", in: .defaultContext)!
		self.init(entity: entity, insertInto: .defaultContext)
		self.contractAddress = contractAddress
		self.balance = balance
		self.exchangeRate = exchangeRate
		self.symbol = symbol
		self.network = network?.rawValue
	}
}

extension Coin {
	static var testUSDT: Coin {
		Coin.init(contractAddress: "0xdAC17F958D2ee523a2206206994597C13D831ec7", balance: "0.5", exchangeRate: "1", symbol: "USDT", network: Network.ethereum)
	}
	
	static var testETH: Coin {
		Coin.init(balance: "0.5", exchangeRate: "1", symbol: "ETH", network: Network.ethereum)
	}
}
