//
//  KeychainManager.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/24.
//

import Foundation
import LocalAuthentication

enum KeychainError: Error {
	case deleteItemFailed(status: OSStatus)
}

class KeychainManager {
	static func createBioAccessControl() throws -> SecAccessControl {
		if let access = SecAccessControlCreateWithFlags(
			nil,
			kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
			.userPresence,
			nil
		) {
			return access
		}
		throw BioAccessError.CreateFailed
	}
	
	@discardableResult
	static func setItemWithBiometry(_ string: String, key: String) throws -> OSStatus {
		guard let data = string.data(using: .utf8) else {
			throw NSError(domain: "/KeychainManager String can't be encoded into data", code: 0)
		}
		let access = try createBioAccessControl()
		let query = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key,
			kSecAttrAccessControl: access as Any,
			kSecValueData: data,
			kSecReturnData: true
		] as CFDictionary
		let status = SecItemAdd(query, nil)
		return status
	}
	
	@discardableResult
	static func setItem(_ string: String, key: String) throws -> OSStatus {
		guard let data = string.data(using: .utf8) else {
			throw NSError(domain: "/KeychainManager String can't be encoded into data", code: 0)
		}
		let query = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key,
			kSecValueData: data,
			kSecReturnData: true
		] as CFDictionary
		let status = SecItemAdd(query, nil)
		return status
	}
	
	static func getItem(key: String) -> AnyObject? {
		let query = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key,
			kSecMatchLimit: kSecMatchLimitOne,
			kSecReturnAttributes: true,
			kSecReturnData: true
		]  as CFDictionary
		var result: AnyObject?
		SecItemCopyMatching(query, &result)
		return result
	}
	
	static func deleteItem(key: String) throws {
		let query = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key
		] as CFDictionary

		let status = SecItemDelete(query as CFDictionary)

		guard status == errSecSuccess || status == errSecItemNotFound else {
			throw KeychainError.deleteItemFailed(status: status)
		}
	}
}

