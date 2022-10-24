//
//  SaveUserSencitiveInfoUseCase.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import Foundation
import WalletCore

protocol SaveUserSencitiveInfoUseCase {
	func execute(mneomonic: String, password: String)
}

final class SaveUserSencitiveInfoImpl {
	
}

extension SaveUserSencitiveInfoImpl: SaveUserSencitiveInfoUseCase {
	func execute(mneomonic: String, password: String) {
		let wallet = HDWallet(mnemonic: mneomonic, passphrase: password)
		wallet?.getAddressForCoin(coin: .ethereum)
	}
}
