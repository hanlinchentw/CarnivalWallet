//
//  MenuItem.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/5.
//

import Foundation

enum MenuItem: Int, CaseIterable, Identifiable {
	case Wallet = 0
	case Etherscan
	case Logout
	
	var title: String {
		switch self {
		case .Wallet:
			return "Wallet"
		case .Etherscan:
			return "View on Etherscan"
		case .Logout:
			return "Log out"
		}
	}
	
	var imageName: String {
		switch self {
		case .Wallet:
			return "wallet"
		case .Etherscan:
			return "eye"
		case .Logout:
			return "rectangle.portrait.and.arrow.right"
		}
	}
	
	var id: Int {
		hashValue
	}
}
