//
//  HistoryPresenter.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/3.
//

import Foundation

struct HistoryPresenter {
	var account: AccountEntity {
		.testEthAccountEntity
//		AccountManager.current!
	}
	
	let coin: Coin
	let transaction: History
	
	var action: TxAction {
		if transaction.from == account.address {
			return .send
		} else {
			return .receive
		}
	}
	
	var iconString: String {
		return action == .receive ? "arrow.down.to.line.circle" : "arrow.up.right.circle"
	}
	
	var title: String {
		return action == .receive ? "Received \(coin.symbol ?? "")" : "Sent \(coin.symbol ?? "")"
	}
	
	var subTitle: String {
		return "Confirm"
	}
	
	var amount: String {
		if let amount = transaction.amount, let symbol = coin.symbol {
			return "\(amount) \(symbol)"
		}
		return ""
	}
}

extension HistoryPresenter {
	enum TxAction {
		case receive
		case send
	}
}
