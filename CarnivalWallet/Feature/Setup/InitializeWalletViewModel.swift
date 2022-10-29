//
//  ImportPhraseViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/29.
//

import Foundation
import LocalAuthentication
import Defaults
import WalletCore
import SwiftUI
import Combine
import RegexBuilder

class MnemonicInvalidError: Error {}

protocol InitializeWalletViewModel: ObservableObject {
	func importWallet()
	func createWallet()
}

final class InitializeWalletViewModelImpl: InitializeWalletViewModel {
	@Published var error: Error?
	@Published var phrase: String = ""
	@Published var passwordText: String = ""
	@Published var confirmPasswordText: String = ""
	@Published var isBioAuthOn: Bool = true

	var set = Set<AnyCancellable>()

	var isPhraseValid: Bool { return (self.error as? MnemonicInvalidError) == nil }

	var importBtnDisabled: Bool {
		passwordText.count < 8 ||
		confirmPasswordText.count < 8 ||
		passwordText != confirmPasswordText
	}
	
	var passwordStrength: PasswordStrength? {
		PasswordStrengthUtils.findPasswordStrength(password: passwordText)
	}
	
	var wordList: Array<String> {
		let space = " "
		return phrase.components(separatedBy: space)
	}
	
	init() {
		onPhraseTextFieldEditing()
	}
}

extension InitializeWalletViewModelImpl {
	func importWallet() {
		if !Mnemonic.isValid(mnemonic: phrase) {
			error = MnemonicInvalidError.init()
			return
		}
		do {
			try SecureManager.setGenericPassword(password: passwordText, useBioAuth: isBioAuthOn)
			let _ = try SecureManager.keystore.import(mnemonic: phrase, name: "Wallet 1", encryptPassword: passwordText, coins: [.ethereum])
		} catch {
			self.error = error
		}
	}

	func createWallet() {
		do {
			try SecureManager.setGenericPassword(password: passwordText, useBioAuth: isBioAuthOn)
			let wallet = try SecureManager.keystore.createWallet(name: "Wallet 1", password: passwordText, coins: [.ethereum])
			self.phrase = try ObjectUtils.checkNotNil(wallet.key.decryptMnemonic(password: Data(passwordText.utf8)), message: "Mnemonic is nil.")
		} catch {
			self.error = error
		}
	}
	
	func deleteWallet() {
		do {
			try SecureManager.keystore.wallets.forEach { wallet in
				try SecureManager.keystore.delete(wallet: wallet, password: passwordText)
			}
		} catch {
			
		}
	}
}

extension InitializeWalletViewModelImpl {
	func onPhraseTextFieldEditing() {
		$phrase.sink { phraseText in
			self.error = nil
		}
		.store(in: &set)
	}
}
