//
//  WalletViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/5.
//

import Foundation
import CoreData
import BigInt

class WalletViewModel: ObservableObject {
	@Published var account: AccountEntity?
	@Published var coins: Array<Coin> = []
	
	func updateAccountAndAddres(account: AccountEntity?) {
		guard let account = account,
					let coins =  account.coin else {
			return
		}
		self.account = account
		self.coins = coins.toArray(Coin.self)
	}
	
	func fetchBalance() {
		guard let account = account else {
			return
		}
		var operations: [(any BalanceProvider, Coin)] = []
		for coin in coins {
			if isToken(coin) {
				let provider = TokenBalanceProvider(address: account.address!, contractAddress: coin.contractAddress)
				operations.append((provider, coin))
			} else {
				let provider = CoinBalanceProvider(address: account.address!)
				operations.append((provider, coin))
			}
		}
		
		for operation in operations {
			let (provider, coin) = operation
			Task {
				if let balanceInMinimumUnit = BigInt(try await provider.getBalance()) {
					let balance = EtherNumberFormatter.full.string(from: balanceInMinimumUnit, decimals: coin.decimals.toInt())
					coin.balance = balance
					DispatchQueue.main.async {
						try? NSManagedObjectContext.defaultContext.save()
					}
				}
			}
		}
	}

	func isToken(_ coin: Coin) ->  Bool {
		return coin.contractAddress != nil
	}
}
