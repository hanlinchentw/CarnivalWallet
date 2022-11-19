//
//  WalletCoordinator.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/19.
//

import Foundation
import UIKit
import SwiftUI

class WalletCoordinator: ObservableObject {
	var childCoordinators: [Coordinator] = []
	
	weak var parent: HomeCoordinator?
	
	var navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() -> some View {
		let walletView = WalletView(currentAccount: parent?.currentAccount)
			.environmentObject(self)
		return walletView
	}
	
	func getWalletView() {
		return
	}
	
	func addToken() {
		let addTokenVC = UIHostingController(rootView: ImportTokenView().environmentObject(self))
		navigationController.pushViewController(addTokenVC, animated: true)
	}
	
	func didFinishAddToken() {
		navigationController.popViewController(animated: true)
	}
}
