//
//  CreateWalletUseCase.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/24.
//

import Foundation
import web3swift

enum CreateWalletValidationError: Error {
	
}

protocol CreateWalletUseCase {
	func execute(mnemonic: String, password: String, confirmPassword: String, useBioAuth: Bool)
}

final class CreateWalletUseCaseImpl: ObservableObject {
	@Published var error: CreateWalletValidationError?
}

extension CreateWalletUseCaseImpl: CreateWalletUseCase {
	func execute(mnemonic: String, password: String, confirmPassword: String, useBioAuth: Bool) {
		
	}
}
