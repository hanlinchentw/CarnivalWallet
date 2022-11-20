//
//  ImportTokenViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/19.
//

import Foundation
import WalletCore
import CoreData

class ImportTokenViewModel: ObservableObject {
	weak var coordinator: WalletCoordinator?
	
	@Published var contractAddress: String = ""
	@Published var tokenInfo: Token?
	@Published var presentScanQRCodeView = false
	@Published var isLoading = false
	@Published var error: (any Error)?
	
	var dismiss: () -> Void {
		{
			self.coordinator?.didFinishAddToken()
		}
	}
	
	var onImport: () -> Void {
		{
			guard let tokenInfo = self.tokenInfo else { return }
			let coin = Coin(tokenInfo: tokenInfo, network: .ethereum)
			AccountManager.shared.currentAccount?.addToCoin(coin)
			try? NSManagedObjectContext.defaultContext.save()
			self.dismiss()
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
	
	func getTokenInfo() {
		isLoading = true
		Task {
			do {
				let provider = TokenInfoProvider(contractAddress: contractAddress)
				let tokenInfo = try await provider.getTokenInfo();
				DispatchQueue.main.async {
					self.tokenInfo = tokenInfo
					self.isLoading = false
				}
			} catch {
				self.error = error
			}
		}
	}
}
