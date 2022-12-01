//
//  RouteName.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/29.
//

import Foundation

enum RouteName {
	case importToken
	case receive(Coin)
	case send(Coin)
	case sendAmount(coin: Coin, toAddress: String)
	case coin(Coin)
	
	var name: String? {
		switch self {
		case .importToken:
			return "Import Tokens"
		case .receive:
			return "Receive"
		case .send:
			return "Send"
		case .sendAmount:
			return "Amount"
		case .coin:
			return "Coin"
		}
	}
}

extension RouteName: Hashable {}
