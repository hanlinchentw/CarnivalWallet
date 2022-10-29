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

protocol ImportPhraseViewModel {
	func create()
}

final class ImportPhraseViewModelImpl: ObservableObject, ImportPhraseViewModel {
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
	
	init() {
		onPhraseTextFieldEditing()
	}
}

extension ImportPhraseViewModelImpl {
	func create() {
		if !Mnemonic.isValid(mnemonic: phrase) {
			error = MnemonicInvalidError.init()
			return
		}
		do {
			try SecureManager.setGenericPassword(password: passwordText, mnemonic: phrase, useBioAuth: isBioAuthOn)
			let _ = try SecureManager.keystore.import(mnemonic: phrase, name: "Wallet 1", encryptPassword: passwordText, coins: [.ethereum])
		} catch {
			self.error = error
		}
	}
}

extension ImportPhraseViewModelImpl {
	func onPhraseTextFieldEditing() {
		$phrase.sink { phraseText in
			self.error = nil
		}
		.store(in: &set)
	}
}
