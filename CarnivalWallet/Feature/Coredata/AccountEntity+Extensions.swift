//
//  AccountEntity+Extensions.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/31.
//

import Foundation
import CoreData
import Defaults

extension AccountEntity {
	@discardableResult
	convenience init(index: Int, name: String, address: String) {
		let entity = NSEntityDescription.entity(forEntityName: "AccountEntity", in: .defaultContext)!
		self.init(entity: entity, insertInto: .defaultContext)
		self.index = index.toString()
		self.name = name
		self.address = address
		self.addToCoin(.createETH())
	}
}
extension AccountEntity {
	var totalFiatBalance: String {
		let totalFiatBalance = (self.coin?.toArray(Coin.self) ?? [])
			.map { ($0.fiatBalance ?? "0").toDouble()}
			.reduce(0.0) { $0 + $1 }
		let fiatFormatter = NumberFormatter()
		fiatFormatter.numberStyle = .decimal
		fiatFormatter.maximumFractionDigits = 4
		return fiatFormatter.string(from: .init(value: totalFiatBalance)) ?? "0"
	}
}
// MARK: - Mock data
extension AccountEntity {
	static var testEthAccountEntity: AccountEntity {
		let entity = AccountEntity.init(index: 0, name: "Account 1", address: "0x1e200594af3E23462a035076F3499295734a3c1d")
		entity.fiatBalance = "176.56"
		entity.addToCoin(Coin.testUSDT)
		return entity
	}
}
