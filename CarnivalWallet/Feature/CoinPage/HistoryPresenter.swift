//
//  HistoryPresenter.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/3.
//

import Foundation
import SwiftUI

struct HistoryPresenter {
	var account: AccountEntity {
		AccountManager.current!
	}
	
	let coin: Coin
	let transaction: History
	
	var action: TxAction {
		guard let from = transaction.from,
					let address = account.address else {
			return .none
		}
						
		if from.caseInsensitiveEqual(address) {
			return .send
		} else {
			return .receive
		}
	}

	var iconString: String {
		switch action {
		case .receive:
			return "arrow.down.to.line.circle"
		case .send:
			return "arrow.up.right.circle"
		case .none:
			return "circle.dotted"
		}
	}
	
	var title: String? {
		switch action {
		case .receive:
			return "Received \(coin.symbol ?? "")"
		case .send:
			return "Sent \(coin.symbol ?? "")"
		case .none:
			return nil
		}
	}
	
	var subTitle: String {
		return transaction.isConfirm ? "Confirmed" : "Unconfirmed"
	}
	
	var subTitleColor: Color {
		return transaction.isConfirm ? Color.greenDark : Color.orangeNormal
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
		case none
	}
}
