//
//  SendCoordinator.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/22.
//

import Foundation
import UIKit
import SwiftUI

class SendCoordinator: Coordinator {
	var sendCoin: Coin

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
}
