//
//  Defaults.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/24.
//

import Foundation
import Defaults

extension Defaults.Keys {
	static let isBioAuth = Key<Bool>("isBioAuth", default: false)
	static let ethExtendedKey = Key<String?>("ethExtendedKey")
}
