//
//  MenuSection.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/5.
//

import Foundation

enum MenuSection: Int, CaseIterable {
	case feature = 0
	case link
	case setting
	
	
	var items: Array<MenuItem> {
		switch self {
		case .feature:
			return [.Wallet, .Browser, .WalletConnect]
		case .link:
			return [.Etherscan]
		case .setting:
			return [.Logout]
		}
	}
	
	var id: Int {
		hashValue
	}
}
