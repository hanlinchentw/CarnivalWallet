//
//  WalletCoinItemViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/15.
//

import Foundation

struct WalletCoinListItemViewModel {
	var coin: Coin
	
	init(coin: Coin) {
		self.coin = coin
	}
	
	var balance: String? {
		let number = ((coin.balance ?? "0").toDouble() as NSNumber)
		let balance = Formatter.withSeparator.string(from: number)
		return balance
	}
	
	var symbol: String? {
		return coin.symbol
	}
	
	var network: String? {
		return coin.network
	}
	
	var contractAddress: String? {
		return coin.contractAddress
	}
}
