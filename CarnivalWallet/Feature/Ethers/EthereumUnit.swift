//
//  EthereumUnit.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/15.
//

import Foundation

public enum EthereumUnit: Int64 {
	case wei = 1
	case kwei = 1_000
	case gwei = 1_000_000_000
	case ether = 1_000_000_000_000_000_000
}

extension EthereumUnit {
	var name: String {
		switch self {
		case .wei: return "Wei"
		case .kwei: return "Kwei"
		case .gwei: return "Gwei"
		case .ether: return "Ether"
		}
	}
}
