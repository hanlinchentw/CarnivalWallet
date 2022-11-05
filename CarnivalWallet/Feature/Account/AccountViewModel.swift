//
//  AccountViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/3.
//

import Foundation

class AccountViewModel: ObservableObject {
	@Published var currentAccount: AccountEntity?
	
	init() {
		initAccount()
	}
}

extension AccountViewModel {
	func initAccount() {
		do {
			self.currentAccount = try AccountEntity.first(.defaultContext)
		} catch {
			
		}
	}
}
