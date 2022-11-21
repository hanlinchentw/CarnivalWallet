//
//  ImportTokenViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/19.
//

import Foundation
import WalletCore
import CoreData
import Combine

@MainActor
class ImportTokenViewModel: ObservableObject {
	@Published var contractAddress: String = ""
	@Published var tokenInfo: Token?
	@Published var presentScanQRCodeView = false
	@Published var isLoading = false
	@Published var error: (any Error)?
	@Published var dismiss = PassthroughSubject<Void, Never>()

	var errorMessage: String? {
		error?.localizedDescription.errorDescription
	}

	var onImport: () -> Void {
		{
			guard let tokenInfo = self.tokenInfo else { return }
			let coin = Coin(tokenInfo: tokenInfo, network: .ethereum)
			let isExisted = AccountManager.coins.contains(where: { $0.contractAddress == coin.contractAddress })
			if isExisted {
				self.error = ImportTokenError.aleardyExisted.rawValue
				return
			}
			AccountManager.shared.currentAccount?.addToCoin(coin)
			try? NSManagedObjectContext.defaultContext.save()
			self.dismiss.send()
		}
	}
	
	var onSearch: () -> Void {
		{
			self.getTokenInfo()
		}
	}
	var onPaste: (_ text: String) -> Void {
		{ text in
			self.contractAddress = text
			self.getTokenInfo()
		}
	}
	
	var onClickScanButton: () -> Void {
		{
			self.presentScanQRCodeView = true
		}
	}
	
	var onScan: (_ result: String) -> Void {
		{ result in
			self.contractAddress = result
			self.presentScanQRCodeView = false
			self.getTokenInfo()
		}
	}
	
	var onCloseQRScanner: () -> Void {
		{
			self.presentScanQRCodeView = false
		}
	}
	
	@MainActor
	func getTokenInfo() {
		defer {
			isLoading = false
		}
		
		isLoading = true
		Task {
			do {
				let provider = TokenInfoProvider(contractAddress: contractAddress)
				let tokenInfo = try await provider.getTokenInfo();
				self.tokenInfo = tokenInfo
			} catch {
				self.error = ImportTokenError.apiFailed.rawValue
			}
		}
	}
}

extension ImportTokenViewModel {
	enum ImportTokenError: String, Error {
		case aleardyExisted = "Token already existed in your wallet"
		case apiFailed = "Invalid Contract address"
	}
}
