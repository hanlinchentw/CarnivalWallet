//
//  TransactionViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/23.
//

import Foundation

class TransactionViewModel {
	let rawData: RawData
	let coin: Coin
	// MARK: - Lifecycle
	init(coin: Coin, rawData: RawData) {
		self.rawData = rawData
		self.coin = coin
	}
}
