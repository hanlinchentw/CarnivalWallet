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
	@Published var currentAccountIndex: Int?

	var currentAccount: AccountEntity? {
		#if DEBUG
		return .testEthAccountEntity
		#endif
		return try? AccountEntity.find(for: ["index": (currentAccountIndex ?? 0).toString()], in: .defaultContext)[0]
	}

	var coins: Array<Coin> {
		currentAccount?.coin?.allObjects as? Array<Coin> ?? []
	}

	var set = Set<AnyCancellable>()
}

extension AccountViewModel {
	func obseveCurrentAccountIndex() {
		Defaults.observe(.accountIndex) { change in
			print(">>> switch Account index: \(change.newValue)")
			self.currentAccountIndex = change.newValue
			
		}.tieToLifetime(of: self)
	}
}


class Mock_AccountViewModel: AccountViewModel {
	override var currentAccount: AccountEntity? {
		return .testEthAccountEntity
	}
}
