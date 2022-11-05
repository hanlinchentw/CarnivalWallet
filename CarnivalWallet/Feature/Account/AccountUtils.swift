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

final class AccountManager {
	static var numOfAccount: Int {
		let accounts = try? AccountEntity.allIn(.defaultContext)
		return accounts?.count ?? 0
	}

	static func addAccount(password: String?) throws {
		var defaultExtendedKey = Defaults[.ethExtendedKey]
		var defaultPassword = password

		if defaultExtendedKey == nil {
			if password == nil {
				defaultPassword = try SecureManager.getGenericPassowrd()
			}
			let wallet = SecureManager.keystore.wallets[0]
			let phrase = try SecureManager.getGenericMnemonic(password: defaultPassword!)
			let hdWallet = HDWallet(mnemonic: phrase, passphrase: defaultPassword!)
			let zpub = hdWallet!.getExtendedPublicKey(purpose: .bip44, coin:CoinType .ethereum, version: .zpub)
			defaultExtendedKey = zpub
			Defaults[.ethExtendedKey] = zpub
		}

		let eth = CoinType.ethereum
		
		let path = DerivationPath(purpose: eth.purpose, coin: eth.slip44Id, account: 0, change: 0, address: 0)
		let pubkey = HDWallet.getPublicKeyFromExtended(extended: defaultExtendedKey!, coin: eth, derivationPath: path.description)!
		let address = eth.deriveAddressFromPublicKey(publicKey: pubkey)
		let account = AccountEntity(index: numOfAccount, name: "Account \(numOfAccount+1)", address: address)
		try NSManagedObjectContext.defaultContext.save()
	}
}
