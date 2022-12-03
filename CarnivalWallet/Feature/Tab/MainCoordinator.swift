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
		if SecureManager.keystore.wallets.isEmpty {
			let welcomeView = WelcomeView().environmentObject(self)
			let welcomeVC = UIHostingController(rootView: welcomeView)
			navigationController.pushViewController(welcomeVC, animated: true)
		} else {
			let homeView = HomeView().environmentObject(self).environment(\.managedObjectContext, .defaultContext)
			let homeVC = UIHostingController(rootView: homeView)
			navigationController.pushViewController(homeVC, animated: true)
		}
	}

	func finishSetup() {
		let homeView = HomeView().environmentObject(self).environment(\.managedObjectContext, .defaultContext)
		let homeVC = UIHostingController(rootView: homeView)
		navigationController.setViewControllers([homeVC], animated: true)
	}
	
	func logout() {
		let welcomeView = WelcomeView().environmentObject(self)
		let welcomeVC = UIHostingController(rootView: welcomeView)
		navigationController.setViewControllers([welcomeVC], animated: true)
	}
}
