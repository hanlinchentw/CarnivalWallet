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
	@Published var currentAccount: AccountEntity? = nil
	
	init() {
		observeAccountChange()
	}
	
	static var current: AccountEntity? {
		Self.shared.currentAccount
	}
	
	static var coins: Array<Coin> {
		Self.current?.coin?.toArray(Coin.self) ?? []
	}

	func observeAccountChange() {
		Defaults.observe(.accountIndex) { [weak self] change in
			guard let self = self else { return }
			self.currentAccount = try? AccountEntity.find(for: ["index": (change.newValue).toString()], in: .defaultContext).first as? AccountEntity
		}
		.tieToLifetime(of: self)
	}

	static var numOfAccount: Int {
		let accounts = try? AccountEntity.allIn(.defaultContext)
		return accounts?.count ?? 0
	}
	
	func addAccount(password: String?) throws {
		let address = try getAddressFromExtendedKey(password: password)
		AccountEntity.init(index: Self.numOfAccount, name: "Account \(Self.numOfAccount+1)", address: address)
		try NSManagedObjectContext.defaultContext.save()
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
