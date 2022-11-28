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
	var coins: Array<Coin> {
		AccountManager.current?.coin?.toArray(Coin.self) ?? []
	}
	
	var accountName: String? {
		AccountManager.current?.name
	}
	
	var accountBalance: String? {
		AccountManager.current?.fiatBalance
	}
	
	var accountAddress: String? {
		AccountManager.current?.address
	}
	
	func fetchBalance() {
		guard let account = AccountManager.shared.currentAccount else { return }
		var operations: [(any BalanceProvider, Coin)] = []

		for coin in coins {
			if let contractAddress = coin.contractAddress {
				let provider = TokenBalanceProviderImpl(address: account.address!, contractAddress: contractAddress)
				operations.append((provider, coin))
			} else {
				let provider = BalanceProviderImpl(address: account.address!)
				operations.append((provider, coin))
			}
		}

		for operation in operations {
			let (provider, coin) = operation
			Task {
				do {
					if let balanceInMinimumUnit = BigInt(try await provider.getBalance()) {
						let balance = EtherNumberFormatter.full.string(from: balanceInMinimumUnit, decimals: coin.decimals.toInt())
						DispatchQueue.main.async {
							coin.balance = balance
							try? NSManagedObjectContext.defaultContext.save()
						}
					}
				} catch {
					print("error >>> \(error.localizedDescription)")
				}
			}
		}
	}
}
