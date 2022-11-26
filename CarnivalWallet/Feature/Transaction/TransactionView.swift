//
//  TransactionView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/23.
//

import Foundation
import UIKit
import WalletCore
import Combine

class TransactionView: UIView {
	@Published var presenter: TransactionPresenter? = nil

	private let totalAmountStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.alignment = .center
		stack.spacing = 12
		return stack
	}()

	private let detailCardContainer: UIStackView = {
		let stack = UIStackView()
		stack.backgroundColor = .black.withAlphaComponent(0.03)
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
		label.textColor = .black.withAlphaComponent(0.6)
		return label
	}()
	
	private let totalAmountLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textAlignment = .center
		return label
	}()

	// Amount
	private let amountTitleLabel = TransactionPresenter.createDetailTitleLabel(type: .amount)
	private let amountLabel = TransactionPresenter.createDetailContentLabel()
	
	// Fee
	private let feeTitleLabel = TransactionPresenter.createDetailTitleLabel(type: .fee)
	private let feeLabel = TransactionPresenter.createDetailContentLabel()
	
	// From
	private let fromAddressTitleLabel = TransactionPresenter.createDetailTitleLabel(type: .from)
	private let fromAddressLabel = TransactionPresenter.createDetailContentLabel {
		$0.lineBreakMode = .byTruncatingMiddle
	}
	
	// To
	private let toAddressTitleLabel = TransactionPresenter.createDetailTitleLabel(type: .to)
	private let toAddressLabel = TransactionPresenter.createDetailContentLabel {
		$0.lineBreakMode = .byTruncatingMiddle
	}

	var set = Set<AnyCancellable>()

	init(presenter: TransactionPresenter? = nil) {
		self.presenter = presenter
		super.init(frame: .zero)
		setupTotalAmountLabel()
		setupAmountCardContainer()
		reactToPresenter()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func reactToPresenter() {
		$presenter.filter{ !$0.isNil }.sink { [weak self] presenter in
			guard let self = self,
						let presenter = presenter else { return }
			self.amountLabel.text = presenter.amountDisplayText
			self.fromAddressLabel.text = presenter.fromAddress
			self.toAddressLabel.text = presenter.toAddress
			self.feeLabel.text = presenter.feeDisplayText
			self.totalAmountLabel.attributedText = presenter.totalAmountDisplayText
		}
		.store(in: &set)
	}
}

extension TransactionView {
	func setupTotalAmountLabel() {
		totalAmountStackView.addArrangedSubview(totalTitleLabel)
		totalAmountStackView.addArrangedSubview(totalAmountLabel)
		addSubview(totalAmountStackView)
		totalAmountStackView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			totalAmountStackView.topAnchor.constraint(equalTo: topAnchor),
			totalAmountStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
	}

	func setupAmountCardContainer() {
		let amountStack = UIStackView(arrangedSubviews: [amountTitleLabel, amountLabel])
		amountStack.axis = .horizontal
		amountStack.distribution = .fillProportionally
		let feeStack = UIStackView(arrangedSubviews: [feeTitleLabel, feeLabel])
		feeStack.axis = .horizontal
		feeStack.distribution = .fillProportionally
		detailCardContainer.addArrangedSubview(amountStack)
		detailCardContainer.addArrangedSubview(feeStack)
		
		let divider = DividerView(color: .black.withAlphaComponent(0.1))
		detailCardContainer.setCustomSpacing(16, after: feeStack)
		detailCardContainer.addArrangedSubview(divider)
		detailCardContainer.setCustomSpacing(16, after: divider)

		let fromStack = UIStackView(arrangedSubviews: [fromAddressTitleLabel, fromAddressLabel])
		fromStack.axis = .horizontal
		fromStack.distribution = .fillEqually

		let toStack = UIStackView(arrangedSubviews: [toAddressTitleLabel, toAddressLabel])
		toStack.axis = .horizontal
		toStack.distribution = .fillEqually
		
		detailCardContainer.addArrangedSubview(fromStack)
		detailCardContainer.addArrangedSubview(toStack)
		
		addSubview(detailCardContainer)
		detailCardContainer.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			detailCardContainer.topAnchor.constraint(equalTo: totalAmountStackView.bottomAnchor, constant: 32),
			detailCardContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
			detailCardContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
		])
	}
}
