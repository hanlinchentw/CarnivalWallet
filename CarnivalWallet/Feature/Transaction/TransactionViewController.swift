//
//  TransactionViewController.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/21.
//

import UIKit
import SwiftUI

class TransactionViewController: UIViewController {
	// MARK: - Properties
	var viewModel: TransactionViewModel!
	var transactionView: TransactionView!
	// MARK: - Lifecycle
	init(coin: Coin, rawData: RawData) {
		self.viewModel = .init(coin: coin, rawData: rawData)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		setupNavBar()
		setupTransactionView()
	}
}

extension TransactionViewController {
	func setupNavBar() {
		let barButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.dismiss(animated:completion:)))
		self.navigationItem.leftBarButtonItem = barButtonItem
		self.navigationItem.title = "Transaction"
	}
	
	func setupTransactionView() {
		transactionView = TransactionView(viewObject: createViewObject())
		view.addSubview(transactionView)
		transactionView.frame = view.bounds
	}
}

extension TransactionViewController {
	func createViewObject() -> TransactionViewObject {
		return .init(
			from: viewModel.rawData.from,
			to: viewModel.rawData.to,
			amount: viewModel.rawData.amount,
			amountSymbol: viewModel.coin.symbol ?? "",
			fee: "0.000237",
			feeSymbol: "ETH"
		)
	}
}
