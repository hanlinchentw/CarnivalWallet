//
//  WalletViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/5.
//

import Foundation

class WalletViewModel: ObservableObject {
	func fetchBalance(address: String) {
		let provider = GetBalanceProvider(address: address)
		Task {
			let balance = try await provider.getBalance()
		}
	}
}
