//
//  PasswordStrengthUtils.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/29.
//

import Foundation

class PasswordStrengthUtils {
	static let weakRegex = /^.{8,}/
	static let mediumRegex = /^(?=.*\d)(?=.*[a-zA-Z]).{8,}$/
	static let strongRegex = /^(?=.*\d)(?=.*[a-zA-Z])(?=.*\W).{8,}$/

	static func findPasswordStrength(password: String) -> PasswordStrength? {
		if let _ = try? Self.strongRegex.wholeMatch(in: password) {
			return .strong
		} else if let _ = try? Self.mediumRegex.wholeMatch(in: password) {
			return .medium
		} else if let _ = try? Self.weakRegex.wholeMatch(in: password) {
			return .weak
		}
		return nil
	}
}
