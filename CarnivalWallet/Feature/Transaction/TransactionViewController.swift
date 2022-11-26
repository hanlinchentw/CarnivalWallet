//
//  TransactionViewController.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/21.
//

import UIKit
import SwiftUI
import Combine

class TransactionViewController: UIViewController {
	// MARK: - Properties
	var viewModel: TransactionViewModel!
	
	private let coinIconImageView: UIImageView = {
		let iv = UIImageView()
		iv.layer.cornerRadius = 28
		iv.contentMode = .scaleAspectFill
		return iv
	}()
	
	let transactionView = TransactionView()
	
	private lazy var confirmButton: UIButton = {
		var config = UIButton.Configuration.filled()
		config.baseBackgroundColor = UIColor.black
		config.baseForegroundColor = .white
		config.title = "Confirm"
		config.attributedTitle = .init("Confirm", attributes: .init([.font: UIFont.AvenirNextMedium(size: 16)]))
		config.cornerStyle = .capsule
		let button = UIButton(configuration: config)
		button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
		return button
	}()

	var set = Set<AnyCancellable>()
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
		setupCoinIconView()
		setupTransactionView()
		setupConfirmButton()
		bindCoinIcon()
		bindRawData()
		Task { await viewModel.getGasFee() }
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		viewModel.loadCoinIcon()
	}
	@objc func confirmButtonTapped() {
		viewModel.signTransfer()
	}
	
	func bindCoinIcon() {
		viewModel.$coinIconData.sink { data in
			if let data {
				self.coinIconImageView.image = UIImage(data: data)
			}
		}
		.store(in: &set)
	}
	
	func bindRawData() {
		viewModel.$rawData.sink { rawData in
			print("new RawData >>> \(rawData)")
			let presenter = TransactionPresenter(coin: self.viewModel.coin, rawData: rawData)
			self.transactionView.presenter = presenter
		}
		.store(in: &set)
	}
}
// MARK: - UI Setup
extension TransactionViewController {
	func setupNavBar() {
		let barButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.dismiss(animated:completion:)))
		self.navigationItem.leftBarButtonItem = barButtonItem
		self.navigationItem.title = "Transaction"
	}
	
	func setupCoinIconView() {
		view.addSubview(coinIconImageView)
		coinIconImageView.translatesAutoresizingMaskIntoConstraints = false
		coinIconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
		coinIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		coinIconImageView.heightAnchor.constraint(equalToConstant: 56).isActive = true
		coinIconImageView.widthAnchor.constraint(equalToConstant: 56).isActive = true
	}
	
	func setupTransactionView() {
		view.addSubview(transactionView)
		transactionView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			transactionView.topAnchor.constraint(equalTo: coinIconImageView.bottomAnchor, constant: 24),
			transactionView.leftAnchor.constraint(equalTo: view.leftAnchor),
			transactionView.rightAnchor.constraint(equalTo: view.rightAnchor),
			transactionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
	}
	
	func setupConfirmButton() {
		view.addSubview(confirmButton)
		confirmButton.translatesAutoresizingMaskIntoConstraints = false
		confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
		confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		confirmButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		confirmButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
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
