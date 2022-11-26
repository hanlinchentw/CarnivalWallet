//
//  MainCoordinator.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/5.
//

import Foundation
import SwiftUI

class MainCoordinator: ObservableObject, Coordinator {
	var childCoordinators: [Coordinator] = []
	
	var navigationController: UINavigationController

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		self.navigationController.navigationBar.isHidden = true
		let homeView = HomeView()
		let homeVC = UIHostingController(rootView: homeView)
		navigationController.pushViewController(homeVC, animated: true)
		if SecureManager.keystore.wallets.isEmpty {
			setup()
		}
	}

	func setup() {
		let welcomeView = WelcomeView().environmentObject(self)
		let welcomeVC = UIHostingController(rootView: welcomeView)
		navigationController.pushViewController(welcomeVC, animated: true)
	}
	
	func finishSetup() {
		let homeView = HomeView()
		let homeVC = UIHostingController(rootView: homeView)
		navigationController.pushViewController(homeVC, animated: true)
	}
}
