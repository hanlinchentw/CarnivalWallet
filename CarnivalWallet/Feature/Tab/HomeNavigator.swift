//
//  Navigator.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/29.
//

import Foundation
import SwiftUI

class NavigatorImpl: ObservableObject, Navigator, WalletNavigator {
	@Published var path = NavigationPath()

	func navigateToSend(coin: Coin) {
		navigate(to: .send(coin))
	}
	
	func navigateToSendAmount(coin: Coin, toAddress: String) {
		navigate(to: .sendAmount(coin: coin, toAddress: toAddress))
	}
	
	func navigateToRecieve(coin: Coin) {
		navigate(to: .receive(coin))
	}
	
	func navigateToImportToken() {
		navigate(to: .importToken)
	}
}
