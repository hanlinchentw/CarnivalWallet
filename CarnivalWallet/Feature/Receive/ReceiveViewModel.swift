//
//  ReceiveViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/30.
//

import Foundation
import SwiftUI

class ReceiveViewModel: ObservableObject {
	
	var account: AccountEntity? {
		AccountManager.current ?? .testEthAccountEntity
	}
	
	func getQRCode(address: String) -> UIImage? {
		let dataSet = QRCodeDataSet(string: address)
		return QRCodeGenerator(set: dataSet).create()
	}
	
	func onCopy() {
		UIPasteboard.general.string = account?.address ?? ""
	}
}
