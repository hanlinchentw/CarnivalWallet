//
//  Utilities.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/26.
//

import Foundation

class ObjectUtils {
	static func checkNotNil<T>(_ object: T?, message: String) throws -> T {
		if (object == nil) {
			throw NSError(domain: message, code: 0)
		}
		return object!
	}
}
