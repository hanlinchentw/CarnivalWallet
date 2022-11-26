//
//  TransactionPresenter.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/26.
//

import Foundation
import UIKit
import Combine
import BigInt
import WalletCore

struct TransactionPresenter {
	var coin: Coin
	var rawData: RawData
	
	init(coin: Coin, rawData: RawData) {
		self.coin = coin
		self.rawData = rawData
	}
	
	var fromAddress: String {
		rawData.from
	}
	
	var toAddress: String {
		if rawData.dataType == .tokenTransfer {
			let (address, _) = ERC20Decoder.decodeTokenTransfer(data: rawData.data)
			return address
		}
		return rawData.to
		
	}
	
	var feeDisplayText: String? {
		guard rawData.fee != nil else {
			return nil
		}
		return "\(fee!) \(feeSymbol!)"
	}
	
	var fee: String? {
		guard let feeInfo = rawData.fee else {
			return nil
		}
		let gasBigInt = BigInt(feeInfo.gas)!
		let gasPriceBigInt = BigInt(feeInfo.gasPrice)!
		let fee = gasBigInt * gasPriceBigInt
		return EtherNumberFormatter.full.string(from: fee)
	}
	
	var feeSymbol: String? {
		guard let feeInfo = rawData.fee else {
			return nil
		}
		return feeInfo.symbol
	}
	
	var amountDisplayText: String {
		"\(amount) \(amountSymbol)"
	}
	
	var amount: String {
		if rawData.dataType == .tokenTransfer {
			let amountPart = String(rawData.data.suffix(64)).trimPrefix0()
			let decodedAmount = BigInt(amountPart, radix: 16)
			return EtherNumberFormatter.full.string(from: decodedAmount!, decimals: coin.decimals.toInt())
		}
		return rawData.amount
	}
	
	var amountSymbol: String {
		coin.symbol!
	}
	
	var totalAmountDisplayText: NSAttributedString? {
		let attributedString = NSMutableAttributedString(string: amountDisplayText,
																										 attributes: [
																											.font : UIFont.AvenirNextBold(size: 28),
																											.foregroundColor: UIColor.black
																										 ])
		guard let fee = fee else {
			return attributedString
		}
		
		if rawData.dataType == .tokenTransfer {
			attributedString.append(.init(string: "\n+ \(feeDisplayText!)",
																		attributes: [
																			.font : UIFont.AvenirNextMedium(size: 18),
																			.foregroundColor: UIColor.black
																		]))
			return attributedString
		} else {
			return NSAttributedString(string: (amount.toDouble() + fee.toDouble()).toString() + " " + amountSymbol)
		}
	}
}
extension TransactionPresenter {
	enum DetailItem: String {
		case amount = "Amount"
		case fee = "Estimated gas fee"
		case from = "From"
		case to = "To"
	}
	
	static func createDetailTitleLabel(type: DetailItem) -> UILabel {
		let label = UILabel()
		label.text = type.rawValue
		label.font = .AvenirNextMedium(size: 14)
		label.textColor = .black.withAlphaComponent(0.6)
		return label
	}
	
	static func createDetailContentLabel(completion: ((UILabel) -> Void)? = nil) -> UILabel {
		let label = UILabel()
		label.textAlignment = .right
		label.font = .AvenirNextMedium(size: 14)
		label.textColor = .black.withAlphaComponent(0.6)
		completion?(label)
		return label
	}
	
	static func createDetailStackView(views: Array<UIView>) {
		let stack = UIStackView(arrangedSubviews: views)
		stack.axis = .horizontal
		stack.distribution = .fillEqually
	}
	
}
