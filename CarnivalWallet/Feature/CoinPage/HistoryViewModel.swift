//
//  HistoryViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/1.
//

import Foundation
import CoreData
import BigInt

class HistoryViewModel: ObservableObject {
	var histories: Array<History> {
		let all = try? History.allIn(.defaultContext) as? [History]
		return all ?? []
	}

	@Published var isLoading = false
	@Published var error: Error?
	
	func fetchTransaction(skipConfirmed: Bool) async {
		setLoading(true)
		do {
			for history in histories {
				
				if history.isConfirm && skipConfirmed { continue }
				let provider = GetTransactionByHashProvider(txHash: history.txHash!)
				let transaction = try await provider.getTransactionByHash()
				let blockProvider = GetBlockByNumberProvider(blockNumber: transaction.blockNumber)
				let timestampInHex = try await blockProvider.getBlockByNumber()
				let timestampNum = BigInt(timestampInHex.drop0x, radix: 16)!.description.toDouble()
				DispatchQueue.main.async {
					history.isConfirm = true
					history.timestamp = timestampNum
					history.from = transaction.from
					history.to = transaction.to
					history.amount = EtherNumberFormatter.full.string(from: BigInt(transaction.value.drop0x, radix: 16)!)
					history.fee = TransactionInfoProvider.calculateFee(gas: transaction.gas, gasPrice: transaction.gasPrice)
					try? NSManagedObjectContext.defaultContext.save()
				}
				setLoading(false)
			}
		} catch {
			print("fetchTransaction >>> error: \(error.localizedDescription)")
			setLoading(false)
		}
	}
	
	func setLoading(_ isLoading: Bool) {
		DispatchQueue.main.async {
			self.isLoading = isLoading
		}
	}
}
