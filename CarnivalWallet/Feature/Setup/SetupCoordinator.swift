//
//  SetupCoordinator.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/29.
//

import UIKit
import SwiftUI

class SetupCoordinator: ObservableObject, Coordinator {
	var childCoordinators = [Coordinator]()
	
	var navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}


	func start() {
		let welcomeView = WelcomeView().environmentObject(self)
		let welcomeVC = UIHostingController(rootView: welcomeView)
		navigationController.navigationBar.isHidden = true
		navigationController.pushViewController(welcomeVC, animated: true)
	}
	
	func finishSetup() {
		let homeView = HomeView()
		let homeVC = UIHostingController(rootView: homeView)
		homeVC.modalPresentationStyle = .fullScreen
		navigationController.present(homeVC, animated: true)
	}
}
