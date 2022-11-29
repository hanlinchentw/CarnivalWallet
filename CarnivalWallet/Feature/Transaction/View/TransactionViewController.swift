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
	var viewModel: TransactionViewModel
	
	private let iconView: UIImageView = {
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
		// UI from top to bottom
		setupNavBar()
		setupCoinIconView()
		setupTransactionView()
		setupConfirmButton()

		// subscribe changes from view model property
		bindCoinIcon()
		bindRawData()
		bindResult()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if viewModel.rawData.fee.isNil {
			viewModel.getGasFee()
		}
		
		viewModel.loadCoinIcon()
	}
	
	func bindCoinIcon() {
		viewModel.$coinIconData.receive(on: RunLoop.main).sink { [weak self] data in
			guard let self = self,
						let data = data else { return }
			self.iconView.image = UIImage(data: data)
		}
		.store(in: &set)
	}
	
	func bindRawData() {
		viewModel.$rawData.sink { [weak self] rawData in
			guard let self = self else { return }
			let presenter = TransactionPresenter(coin: self.viewModel.coin, rawData: rawData)
			self.transactionView.presenter = presenter
		}
		.store(in: &set)
	}
	
	func bindResult() {
		viewModel.$sendResult.receive(on: RunLoop.main).sink { [weak self] result in
			guard let result = result,
						let self = self else { return }
			switch result {
			case .success(_):
				self.navigationController?.dismiss(animated: true, completion: {
					TransactionNotification.Success.post()
				})
				break
			case .failure(let error):
				print("error >>> \(error.localizedDescription)")
				break
			}
		}
		.store(in: &set)
	}

	@objc func confirmButtonTapped() {
		viewModel.signTransfer()
	}

	@objc func cancel() {
		self.navigationController?.dismiss(animated: true)
	}
}
// MARK: - UI Setup
extension TransactionViewController {
	func setupNavBar() {
		let barButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancel))
		self.navigationItem.leftBarButtonItem = barButtonItem
		self.navigationItem.title = "Transaction"
	}

	func setupCoinIconView() {
		view.addSubview(iconView)
		iconView.translatesAutoresizingMaskIntoConstraints = false
		iconView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
		iconView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		iconView.heightAnchor.constraint(equalToConstant: 56).isActive = true
		iconView.widthAnchor.constraint(equalToConstant: 56).isActive = true
	}
	
	func setupTransactionView() {
		view.addSubview(transactionView)
		transactionView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			transactionView.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 24),
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
