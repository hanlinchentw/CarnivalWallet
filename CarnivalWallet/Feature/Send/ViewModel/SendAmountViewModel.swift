//
//  SendAmountViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/28.
//

import Foundation
import SwiftUI
import WalletCore

class SendAmountViewModel: ObservableObject {
	let formatter = EtherNumberFormatter.full
	@Published var sendAmount = ""
	@Published var error: SendAmountError?
	@Published var isSendButtonLoading: Bool = false
	
	var account: AccountEntity {
		AccountManager.getCurrent ?? .testEthAccountEntity
	}

	func onPressMaxButton(coin: Coin) {
		sendAmount = coin.balance ?? ""
	}
	
	@MainActor
	func onPressSendButton(coin: Coin, toAddress: String) async {
		self.isSendButtonLoading = true
		defer {
			self.isSendButtonLoading = false
		}
		do {
			guard let amount = formatter.number(from: sendAmount, decimals: coin.decimals.toInt()) else {
				self.error = SendAmountError.invalidAmount
				return
			}
			let amountString = formatter.string(from: amount, decimals: coin.decimals.toInt())

			guard let balance = coin.balance,
						let balanceBInt = formatter.number(from: balance, decimals: coin.decimals.toInt()),
						balanceBInt >= amount else {
				self.error = SendAmountError.balanceNotEnough
				return
			}
			guard let from = account.address else {
				return
			}
			let rawData = RawDataMapper.mapRawData(
				contractAddress: coin.contractAddress,
				from: from,
				to: toAddress,
				amount: amountString,
				decimals: coin.decimals.toInt()
			)
			let provider = TransactionInfoProvider(
				from: from,
				to: toAddress,
				data: rawData.data,
				amount: amountString,
				contractAddress: coin.contractAddress
			)
			let transactionInfo = try await provider.getTransactionInfo()
			let fee = TransactionInfoProvider.calculateFee(gas: transactionInfo.gas, gasPrice: transactionInfo.gasPrice)
			let feeBInt = formatter.number(from: fee)!

			let balanceNotEnoughForTotal = amount + feeBInt >= balanceBInt

			if balanceNotEnoughForTotal {
				let newAmount = amount - feeBInt

				if newAmount < 0 {
					self.error = SendAmountError.balanceNotEnoughToPayFee(fee)
					return
				}
				let newRawData = RawDataMapper.mapRawData(
					contractAddress: coin.contractAddress,
					from: from,
					to: toAddress,
					amount: formatter.string(from: newAmount, decimals: coin.decimals.toInt()),
					decimals: coin.decimals.toInt(),
					fee: .init(gasPrice: transactionInfo.gasPrice, gas: transactionInfo.gas, symbol: Network.ethereum.rawValue, nonce: transactionInfo.nonce)
				)
				self.startTransaction(coin: coin,rawData: newRawData)
			} else {
				self.startTransaction(coin: coin,rawData: rawData)
			}
		} catch {
			
		}
	}
	
	@MainActor
	func startTransaction(coin: Coin, rawData: RawData) {
		let coordinator = TransactionCoordinator(coin: coin, rawData: rawData)
		coordinator.start()
	}
}

extension SendAmountViewModel {
	enum SendAmountError: Error {
		case balanceNotEnough
		case invalidAmount
		case balanceNotEnoughToPayFee(String)

		var description: String {
			switch self {
			case .balanceNotEnough:
				return "Not enough balance"
			case .invalidAmount:
				return "Invalid input"
			case .balanceNotEnoughToPayFee(let fee):
				return "Not enough balance for transaction fee: \(fee)"
			}
		}	
	}
}

extension SendAmountViewModel {
	class RawDataMapper {
		static func mapRawData(contractAddress: String?, from: String, to: String, amount: String, decimals: Int, fee: Fee? = nil) -> RawData {
			if let contractAddress {
				let sendAmountNumber = EtherNumberFormatter.full.number(from: amount, decimals: decimals)
				let sendHexString = String(sendAmountNumber!, radix: 16).padZeroToEvenLength()
				let data = ERC20Encoder.encodeTransfer(to: to, value: sendHexString).hexString
				return .init(to: contractAddress, from: from, amount: "0", dataType: .tokenTransfer, data: data.add0x, fee: fee)
			}
			return .init(to: to, from: from, amount: amount, dataType: .transfer, data: "0x", fee: fee)
		}
	}
}
