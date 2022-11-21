//
//  HomeCoordinator.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/19.
//

import Foundation
import UIKit
import SwiftUI

class HomeCoordinator: Coordinator, ObservableObject {
	@Published var currentAccountIndex: Int = 0

	var coins: Array<Coin> {
		AccountManager.current?.coin?.allObjects as? Array<Coin> ?? []
	}

	@Published var selectedScreen: Int = 0
	var childCoordinators: [Coordinator] = []
	
	var navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let homeView = HomeView().environmentObject(self)
		let homeVC = UIHostingController(rootView: homeView)
		navigationController.pushViewController(homeVC, animated: true)
	}
	
	func switchScreen(screenIndex: Int) {
		selectedScreen = screenIndex
	}

	
	func startWalletView() -> some View {
		let coordinator = WalletCoordinator(navigationController: navigationController)
		coordinator.parent = self
		return coordinator.start()
	}
}
