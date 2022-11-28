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
	@Published var sendAmount = ""
	@Published var error: SendAmountError?
	@Published var isSendButtonLoading: Bool = false
	
	var account: AccountEntity {
		AccountManager.current ?? .testEthAccountEntity
	}

	func onPressMaxButton(viewObject: SendAmountViewObject) {
		sendAmount = viewObject.coin.balance ?? ""
	}
	
	func onPressSendButton(viewObject: SendAmountViewObject) async {
		do {
			guard let amount = sendAmount.safeToDouble() else {
				self.error = SendAmountError.invalidAmount
				return
			}
			guard let balance = viewObject.coin.balance,
						balance.toDouble() >= amount else {
				self.error = SendAmountError.balanceNotEnough
				return
			}
			guard let from = account.address else {
				return
			}
			DispatchQueue.main.async {
				self.isSendButtonLoading = true
			}
			defer {
				self.isSendButtonLoading = false
			}
			let rawData = RawDataMapper.mapRawData(contractAddress: viewObject.coin.contractAddress, from: from, to: viewObject.sendToAddress, amount: amount.toString(), decimals: viewObject.coin.decimals.toInt())
			let fee = try await TransactionInfoProvider(from: from, to: viewObject.sendToAddress, data: rawData.data, amount: amount.toString(), contractAddress: viewObject.coin.contractAddress).getFee()
			
			if amount + fee.toDouble() > balance.toDouble() {
				let newAmount = amount - fee.toDouble()
				
				if newAmount < 0 {
					DispatchQueue.main.async {
						self.error = SendAmountError.balanceNotEnoughToPayFee(fee)
					}
					return
				}
				print("newAmount >>> \(newAmount.toString()) ")
				let newRawData = RawDataMapper.mapRawData(contractAddress: viewObject.coin.contractAddress, from: from, to: viewObject.sendToAddress, amount: newAmount.toString(), decimals: viewObject.coin.decimals.toInt())
				
				DispatchQueue.main.async {
					let coordinator = TransactionCoordinator(coin: viewObject.coin, rawData: newRawData)
					coordinator.start()
				}
			} else {
				DispatchQueue.main.async {
					let coordinator = TransactionCoordinator(coin: viewObject.coin, rawData: rawData)
					coordinator.start()
				}
			}
		} catch {
			
		}
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
		static func mapRawData(contractAddress: String?, from: String, to: String, amount: String, decimals: Int) -> RawData {
			if let contractAddress {
				let sendAmountNumber = EtherNumberFormatter.full.number(from: amount, decimals: decimals)
				let sendHexString = String(sendAmountNumber!, radix: 16).padZeroToEvenLength()
				let data = ERC20Encoder.encodeTransfer(to: to, value: sendHexString).hexString
				return .init(to: contractAddress, from: from, amount: "0", dataType: .tokenTransfer, data: data.add0x)
			}
			return .init(to: to, from: from, amount: amount, dataType: .transfer, data: "0x")
		}
	}
}
