//
//  TransactionView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/23.
//

import Foundation
import UIKit
import WalletCore

struct TransactionViewObject {
	let from: String
	let to: String
	let amount: String
	let amountSymbol: String
	let fee: String
	let feeSymbol: String
}

class TransactionView: UIView {
	let viewObject: TransactionViewObject
	let onConfirm: VoidClosure

	private let amountCardContainer: UIStackView = {
		let stack = UIStackView()
		stack.backgroundColor = .black
		stack.layer.cornerRadius = 8
		stack.axis = .vertical
		stack.spacing = 4
		stack.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
		stack.isLayoutMarginsRelativeArrangement = true
		return stack
	}()
	
	private let totalTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Total"
		label.font = .AvenirNextMedium(size: 18)
		label.textColor = .white
		return label
	}()
	
	private let totalAmountLabel: UILabel = {
		let label = UILabel()
		label.font = .AvenirNextBold(size: 28)
		label.textColor = .white
		label.numberOfLines = 0
		return label
	}()
	
	private let fromAddressTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "From"
		label.font = .AvenirNextMedium(size: 16)
		label.textColor = .white.withAlphaComponent(0.8)
		return label
	}()
	
	private let fromAddressLabel: UILabel = {
		let label = UILabel()
		label.font = .AvenirNextMedium(size: 16)
		label.textAlignment = .right
		label.textColor = .white.withAlphaComponent(0.8)
		label.lineBreakMode = .byTruncatingMiddle
		return label
	}()
	
	private let toAddressTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "To"
		label.font = .AvenirNextMedium(size: 16)
		label.textColor = .white.withAlphaComponent(0.8)
		return label
	}()

	private let toAddressLabel: UILabel = {
		let label = UILabel()
		label.font = .AvenirNextMedium(size: 16)
		label.textAlignment = .right
		label.textColor = .white.withAlphaComponent(0.8)
		label.lineBreakMode = .byTruncatingMiddle
		return label
	}()

	private let feeLabel: UILabel = {
		let label = UILabel()
		label.font = .AvenirNextMedium(size: 16)
		label.textAlignment = .right
		label.textColor = .white.withAlphaComponent(0.8)
		return label
	}()
	
	private let feeTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Estimated gas fee"
		label.font = .AvenirNextMedium(size: 16)
		label.textColor = .white.withAlphaComponent(0.8)
		return label
	}()
	
	private let amountLabel: UILabel = {
		let label = UILabel()
		label.font = .AvenirNextMedium(size: 16)
		label.textAlignment = .right
		label.textColor = .white.withAlphaComponent(0.8)
		return label
	}()
	
	private let amountTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Amount"
		label.font = .AvenirNextMedium(size: 16)
		label.textColor = .white.withAlphaComponent(0.8)
		return label
	}()
	
	private lazy var confirmButton: UIButton = {
		var config = UIButton.Configuration.filled()
		config.baseBackgroundColor = UIColor.black
		config.baseForegroundColor = .white
		config.title = "Confirm"
		config.attributedTitle = .init("Confirm", attributes: .init([.font: UIFont.AvenirNextBold(size: 20)]))
		config.cornerStyle = .capsule
		let button = UIButton(configuration: config, primaryAction: .init(handler: { _ in
			self.onConfirm()
		}))
		return button
	}()
	
	init(viewObject: TransactionViewObject, onConfirm: @escaping VoidClosure) {
		self.viewObject = viewObject
		self.onConfirm = onConfirm
		super.init(frame: .zero)
		setupAmountCardContainer()
		setupAddressContainer()
		setupConfirmButton()
		setTotalAmount()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension TransactionView {
	func setupAmountCardContainer() {
		amountLabel.text = "\(viewObject.amount) \(viewObject.amountSymbol)"
		feeLabel.text = "\(viewObject.fee) \(viewObject.feeSymbol)"
		amountCardContainer.addArrangedSubview(totalTitleLabel)
		amountCardContainer.addArrangedSubview(totalAmountLabel)
		let divider = DividerView(color: .white.withAlphaComponent(0.3))
		amountCardContainer.setCustomSpacing(20, after: totalAmountLabel)
		amountCardContainer.addArrangedSubview(divider)
		amountCardContainer.setCustomSpacing(20, after: divider)
		let amountStack = UIStackView(arrangedSubviews: [amountTitleLabel, amountLabel])
		amountStack.axis = .horizontal
		amountStack.distribution = .fillProportionally
		let feeStack = UIStackView(arrangedSubviews: [feeTitleLabel, feeLabel])
		feeStack.axis = .horizontal
		feeStack.distribution = .fillProportionally
		amountCardContainer.addArrangedSubview(amountStack)
		amountCardContainer.addArrangedSubview(feeStack)
		addSubview(amountCardContainer)
		amountCardContainer.translatesAutoresizingMaskIntoConstraints = false
		amountCardContainer.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
		amountCardContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
		amountCardContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
	}
	
	func setupAddressContainer() {
		fromAddressLabel.text = viewObject.from
		toAddressLabel.text = viewObject.to
		let fromStack = UIStackView(arrangedSubviews: [fromAddressTitleLabel, fromAddressLabel])
		fromStack.axis = .horizontal
		fromStack.distribution = .fillEqually

		let toStack = UIStackView(arrangedSubviews: [toAddressTitleLabel, toAddressLabel])
		toStack.axis = .horizontal
		toStack.distribution = .fillEqually
		
		let stack = UIStackView(arrangedSubviews: [fromStack, toStack])
		stack.backgroundColor = .black
		stack.layer.cornerRadius = 8
		stack.axis = .vertical
		stack.spacing = 4
		stack.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
		stack.isLayoutMarginsRelativeArrangement = true

		addSubview(stack)
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		stack.topAnchor.constraint(equalTo: amountCardContainer.bottomAnchor, constant: 32).isActive = true
		stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
		stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
	}
	
	func setupConfirmButton() {
		addSubview(confirmButton)
		confirmButton.translatesAutoresizingMaskIntoConstraints = false
		confirmButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
		confirmButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		confirmButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
		confirmButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
		confirmButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
	}
	
	func setTotalAmount() {
		if viewObject.amountSymbol != viewObject.feeSymbol {
			let amountDisplay = "\(viewObject.amount) \(viewObject.amountSymbol)"
			let attributedString = NSMutableAttributedString(string: amountDisplay,
																											 attributes: [
																												.font : UIFont.AvenirNextBold(size: 28),
																												.foregroundColor: UIColor.white
																											 ])

			let feeDisplay = "\n+ \(viewObject.fee) \(viewObject.feeSymbol)"
			attributedString.append(.init(string: feeDisplay,
																		attributes: [
																			.font : UIFont.AvenirNextBold(size: 18),
																			.foregroundColor: UIColor.white
																		]))
			totalAmountLabel.attributedText = attributedString
		} else {
			let totalSpend = (viewObject.amount.toDouble() + viewObject.fee.toDouble()).toString()
			totalAmountLabel.text = totalSpend
		}
	}
}
