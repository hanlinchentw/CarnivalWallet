//
//  SecureManager.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/24.
//

import LocalAuthentication
import Defaults
import WalletCore

enum BioAccessError: Error {
	case EvaluateDisabled
	case CreateFailed
}

class SecureManager {
	static let keyDirectory = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("/Documents").appendingPathComponent("/KeyStore")
	static var keystore: KeyStore {
		return try! KeyStore(keyDirectory: Self.keyDirectory)
	}

	static func useBioAuth() async throws {
		var error: NSError?
		let context = LAContext()
		let canEvaluate = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
		if canEvaluate {
			let policy = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Enable Biometry for keychain access")
			guard !policy else {
				Defaults[.isBioAuth] = false
				throw BioAccessError.EvaluateDisabled
			}
			Defaults[.isBioAuth] = true
		} else {
			Defaults[.isBioAuth] = false
		}
	}

	static func setGenericPassword(password: String, useBioAuth: Bool) throws {
		if useBioAuth {
			Task {
				try await Self.useBioAuth()
				try KeychainManager.setItemWithBiometry(password, key: "wallet_password")
			}
		} else {
			try KeychainManager.setItem(password, key: "wallet_password")
		}
	}
	
	static func getGenericPassowrd() throws -> String? {
		return KeychainManager.getItem(key: "wallet_password") as? String
	}
	
	static func getGenericMnemonic(password: String) throws -> String {
		let keyStore = try KeyStore(keyDirectory: keyDirectory)
		let wallet = keyStore.wallets[0]

		let nilablePrivateKey = wallet.key.decryptPrivateKey(password: Data(password.utf8))
		let privateKey = try ObjectUtils.checkNotNil(nilablePrivateKey, message: "SecureManager.getGenericMnemonic privateKey is nil.")

		let nilableMnemonic = String(data: privateKey, encoding: .ascii)
		let mnemonic = try ObjectUtils.checkNotNil(nilableMnemonic, message: "SecureManager.getGenericMnemonic mnemonic is nil.")

		return mnemonic
	}
	
	static func reset() throws {
		try KeychainManager.deleteItem(key: "wallet_password")
		try FileManager.default.removeItem(at: keyDirectory)
	}
}
