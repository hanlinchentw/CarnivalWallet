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
	@Published var isEditing = false
	var coins: Array<Coin> {
		AccountManager.getCurrent?.coin?.toArray(Coin.self) ?? []
	}
	
	var accountName: String? {
		AccountManager.getCurrent?.name
	}
	
	var accountBalance: String {
		AccountManager.getCurrent?.totalFiatBalance ?? "0"
	}
	
	var accountAddress: String? {
		AccountManager.getCurrent?.address
	}
	
	func deleteCoin(_ coin: Coin) {
		if isEditing {
			coin.delete(in: .defaultContext)
			try? NSManagedObjectContext.defaultContext.save()
		}
	}
	func fetchBalance() {
		print("fetchBalance >>> account >>> \(AccountManager.getCurrent)")
		guard let account = AccountManager.getCurrent else { return }
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
	
	func calculateFiatBalance(coin: Coin) -> String {
		let fiatFormatter = NumberFormatter()
		fiatFormatter.numberStyle = .decimal
		fiatFormatter.maximumFractionDigits = 4

		let exchangeRate = coin.exchangeRate?.toDouble() ?? 0.0
		let balance = coin.balance?.toDouble() ?? 0.0
		let fiatBalance = exchangeRate * balance
		return fiatFormatter.string(from: .init(value: fiatBalance)) ?? "0"
	}
	
	func fetchExchangeRate() {
		Task {
			do {
				for coin in coins {
					guard let symbol = coin.symbol else {
						continue
					}
					let provider = ExchangeRateProvider(symbol: symbol.uppercased())
					let exchangeRate = try await provider.getExchangeRate()
					let fiatBalance = calculateFiatBalance(coin: coin)
					
					DispatchQueue.main.async {
						coin.exchangeRate = exchangeRate.toString()
						coin.fiatBalance = fiatBalance
						try? NSManagedObjectContext.defaultContext.save()
					}
				}
			} catch {
				print(">>> fetchExchangeRate.error=\(error.localizedDescription)")
			}
		}
	}
}
