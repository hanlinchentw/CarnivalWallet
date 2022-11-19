//
//  AccountViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/3.
//

import Foundation
import Defaults
import Combine

class AccountViewModel: ObservableObject {
	@Published var currentAccountIndex: Int = 0

	var currentAccount: AccountEntity? {
		return try? AccountEntity.find(for: ["index": (currentAccountIndex).toString()], in: .defaultContext).first
	}

	var coins: Array<Coin> {
		currentAccount?.coin?.allObjects as? Array<Coin> ?? []
	}
}

class Mock_AccountViewModel: AccountViewModel {
	override var currentAccount: AccountEntity? {
		return .testEthAccountEntity
	}
}
