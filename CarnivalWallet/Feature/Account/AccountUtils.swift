//
//  AccountUtils.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/3.
//

import Foundation
import WalletCore
import CoreData
import Defaults

final class AccountManager: ObservableObject {
	static let shared: AccountManager = .init()
	@Published private var currentAccount: AccountEntity? = nil

	static var setCurrent: (AccountEntity) -> Void {
		{
			self.shared.currentAccount = $0
		}
	}
	
	static var getCurrent: AccountEntity? {
		if let account = Self.shared.currentAccount {
			return account
		}
		return try? AccountEntity.find(for: ["index": "0"], in: .defaultContext).first as? AccountEntity
	}
	
	static var coins: Array<Coin> {
		Self.getCurrent?.coin?.toArray(Coin.self) ?? []
	}

	static var numOfAccount: Int {
		let accounts = try? AccountEntity.allIn(.defaultContext)
		return accounts?.count ?? 0
	}
	
	@discardableResult
	func addAccount(password: String?) throws -> AccountEntity {
		let address = try getAddressFromExtendedKey(password: password)
		let account = AccountEntity.init(index: Self.numOfAccount, name: "Account \(Self.numOfAccount+1)", address: address)
		try NSManagedObjectContext.defaultContext.save()
		return account
	}
	
	static func deleteAll() throws {
		let all = try AccountEntity.allIn(.defaultContext)
		all.forEach { $0.delete(in: .defaultContext) }
	}
	
	func getAddressFromExtendedKey(password: String?) throws -> String {
		var defaultExtendedKey = Defaults[.ethExtendedKey]

		if defaultExtendedKey == nil {
			let hdWallet = try WalletManager.getHDWallet(defaultPassword: password)
			let xpub = hdWallet.getExtendedPublicKey(purpose: .bip44, coin: .ethereum, version: .xpub)
			defaultExtendedKey = xpub
			Defaults[.ethExtendedKey] = xpub
		}
		
		let eth = CoinType.ethereum
		let path = DerivationPath(purpose: .bip44, coin: eth.slip44Id, account: 0, change: 0, address: UInt32(Self.numOfAccount))
		let pubkey = HDWallet.getPublicKeyFromExtended(extended: defaultExtendedKey!, coin: eth, derivationPath: path.description)!
		let address = eth.deriveAddressFromPublicKey(publicKey: pubkey)
		return address
	}
}
