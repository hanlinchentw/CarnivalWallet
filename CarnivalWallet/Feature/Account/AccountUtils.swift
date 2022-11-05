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
		let address = try getAddressFromExtendedKey(password: password)
		AccountEntity.init(index: numOfAccount, name: "Account \(numOfAccount+1)", address: address)
		try NSManagedObjectContext.defaultContext.save()
	}
	
	static func getAddressFromExtendedKey(password: String?) throws -> String {
		var defaultExtendedKey = Defaults[.ethExtendedKey]
		var defaultPassword = password

		if defaultExtendedKey == nil {
			if password == nil {
				defaultPassword = try SecureManager.getGenericPassowrd()
			}
			let phrase = try SecureManager.getGenericMnemonic(password: defaultPassword!)
			let hdWallet = HDWallet(mnemonic: phrase, passphrase: "")
			let xpub = hdWallet!.getExtendedPublicKey(purpose: .bip44, coin: .ethereum, version: .xpub)
			defaultExtendedKey = xpub
			Defaults[.ethExtendedKey] = xpub
		}
		
		let eth = CoinType.ethereum
		let path = DerivationPath(purpose: .bip44, coin: eth.slip44Id, account: 0, change: 0, address: UInt32(numOfAccount))
		let pubkey = HDWallet.getPublicKeyFromExtended(extended: defaultExtendedKey!, coin: eth, derivationPath: path.description)!
		let address = eth.deriveAddressFromPublicKey(publicKey: pubkey)
		return address
	}
}
