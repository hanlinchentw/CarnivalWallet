//
//  SendViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/28.
//

import Foundation
import Combine
import SwiftUI
import WalletCore

class SendViewModel: ObservableObject {
	@Published var qrScannerVisible = false
	@Published var useMax: Bool = false
	@Published var sendAmount = ""
	@Published var sendToAddress = ""

	@Published var toAddressInvalid: (any Error)?
	
	var account: AccountEntity {
		AccountManager.current ?? .testEthAccountEntity
	}
	
	var onPaste: (String) -> Void {
		{ text in
			self.sendToAddress = text
		}
	}
	
	var onScan: (String) -> Void {
		{ text in
			self.sendToAddress = text
		}
	}
	
	var onClickScanButton: VoidClosure {
		{
			self.qrScannerVisible = true
		}
	}
	
	var onCloseScanner: VoidClosure {
		{
			self.qrScannerVisible = true
		}
	}
	
	var nextButtonDisabled: Bool {
		sendToAddress.isEmpty
	}
	
	func onPressNextButton(callback: VoidClosure) {
		let isValidAddress = AnyAddress.isValid(string: sendToAddress, coin: .ethereum)
		if isValidAddress {
			callback()
		} else {
			toAddressInvalid = SendViewError.toAddressInvalid
		}
	}
}
extension SendViewModel {
	enum SendViewError: Error {
		case toAddressInvalid
	}
}
