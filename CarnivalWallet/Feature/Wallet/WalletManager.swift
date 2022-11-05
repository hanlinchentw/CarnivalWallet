//
//  WalletManager.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/4.
//

import Foundation
import WalletCore
import Defaults

final class WalletManager {
	@discardableResult
	static func initWallet(phrase: String? = nil, password: String, useBioAuth: Bool) throws -> Wallet {
		if let phrase {
			if !Mnemonic.isValid(mnemonic: phrase) {
				throw MnemonicInvalidError.init()
			}
			return try SecureManager.keystore.import(mnemonic: phrase, name: "Wallet", encryptPassword: password, coins: [.ethereum])
		} else {
			return try SecureManager.keystore.createWallet(name: "Wallet", password: password, coins: [.ethereum])
		}
	}
}
