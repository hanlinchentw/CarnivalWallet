//
//  SendCoordinator.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/22.
//

import Foundation
import UIKit
import SwiftUI
import WalletCore

class SendCoordinator: ObservableObject, Coordinator {
	@Published var useMax: Bool = false
	@Published var sendAmount = ""
	@Published var sendToAddress = ""
	var sendCoin: Coin

	var account: AccountEntity {
		AccountManager.current!
	}
	
	var balance: String? {
		let coins = account.coin?.toArray(Coin.self) ?? []
		let eth = coins.last(where: { $0.symbol == "ETH" })
		return eth?.balance
	}

	var childCoordinators: [Coordinator] = []
	
	var navigationController: UINavigationController
	
	init(coin: Coin, navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.sendCoin = coin
	}
	
	func start() {
		let sendVC = UIHostingController(rootView: SendView(coordinator: self))
		self.navigationController.pushViewController(sendVC, animated: true)
	}
	
	func confirmAmount() {
		let sendAmountVC = UIHostingController(rootView: SendAmountView(coordinator: self))
		self.navigationController.pushViewController(sendAmountVC, animated: true)
	}
	
	func goBack() {
		if self.navigationController.viewControllers.count == 1 {
			self.navigationController.dismiss(animated: true)
		} else {
			self.navigationController.popViewController(animated: true)
		}
	}
	
	func doTransaction() {
		guard let from = account.address else {
			return
		}

		guard AnyAddress.isValid(string: sendToAddress, coin: .ethereum) else {
			return
		}
		
		let dataType = sendCoin.contractAddress == nil ? DataType.transfer : DataType.tokenTransfer(contractAddress: sendCoin.contractAddress!)
		let rawData = RawData(to: sendToAddress, from: from, amount: sendAmount, dataType: dataType)
		let transactionVC = TransactionViewController(coin: sendCoin, rawData: rawData)
		let nav = UINavigationController(rootViewController: transactionVC)
		self.navigationController.present(nav, animated: true)
	}
}
