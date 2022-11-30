//
//  WalletNavigator.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/30.
//

import Foundation

protocol WalletNavigator {
	func navigateToSend(coin: Coin)
	func navigateToSendAmount(coin: Coin, toAddress: String)
	func navigateToRecieve(coin: Coin)
	func navigateToImportToken()
}
