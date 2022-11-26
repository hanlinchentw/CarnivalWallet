//
//  TransactionCoordinator.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/27.
//

import Foundation
import UIKit

class TransactionCoordinator: Coordinator {
	var childCoordinators: [Coordinator] = []
	
	var navigationController: UINavigationController
	
	var coin: Coin
	var rawData: RawData
	
	init(navigationController: UINavigationController = .init(), coin: Coin, rawData: RawData) {
		self.navigationController = navigationController
		self.coin = coin
		self.rawData = rawData
	}
	
	func start() {
		let transactionVC = TransactionViewController(coin: coin, rawData: rawData)
		navigationController.pushViewController(transactionVC, animated: true)
		
		let topVC = UIApplication.shared.keyWindow?.rootViewController
		topVC?.present(navigationController, animated: true)
	}
	
	
}
