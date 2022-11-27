//
//  SendAmountView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/22.
//

import SwiftUI
import WalletCore

struct SendAmountViewObject: Hashable {
	var coin: Coin
	var sendToAddress: String
}

struct SendAmountView: View {
	@Environment(\.presentationMode) var presentationMode

	var viewObject: SendAmountViewObject

	@Binding var path: NavigationPath
	@State var sendAmount = ""
	@State var useMax: Bool = false
	
	var account: AccountEntity {
		AccountManager.current ?? .testEthAccountEntity
	}
	
	var body: some View {
		VStack {
			VStack(spacing: 16) {
				Text(viewObject.coin.symbol)
					.AvenirNextMedium(size: 14)
					.foregroundColor(.white)
					.capsule(color: .black, radius: 16)
				
				TextField("0", text: $sendAmount)
					.AvenirNextMedium(size: 32)
					.keyboardType(.decimalPad)
					.multilineTextAlignment(.center)
					.padding(.horizontal, 32)

				TextButton("Send Max", color: .blue) {
					self.sendAmount = viewObject.coin.balance ?? ""
				}
				Text("Balance: ", viewObject.coin.balance, " ", viewObject.coin.symbol)
					.AvenirNextRegular(size: 14)
			}
			Spacer()
			
			BaseButton(text: "Send", height: 56, disabled: false, style: .capsule) {
				guard AnyAddress.isValid(string: self.viewObject.sendToAddress, coin: .ethereum) else {
					return
				}
				if let rawData = self.mapRawData() {
					let coordinator = TransactionCoordinator(coin: viewObject.coin, rawData: rawData)
					coordinator.start()
				}
			}
			.padding(16)
		}
		.padding(.top, 90)
		.toolbar(.hidden)
		.header(title: "Amount", leftItem: {
			Image(systemName: "chevron.left")
		}, onPressedLeftItem: {
			path.removeLast()
		})
		.onReceive(TransactionNotification.Success.publisher) { _ in
			path.removeLast()
		}
	}
	
	func mapRawData() -> RawData? {
		guard let from = account.address else {
			return nil
		}
		let sendCoin = viewObject.coin
		let sendToAddress = viewObject.sendToAddress

		if let contractAddress = sendCoin.contractAddress {
			let sendAmountNumber = EtherNumberFormatter.full.number(from: sendAmount, decimals: sendCoin.decimals.toInt())
			let sendHexString = String(sendAmountNumber!, radix: 16).padZeroToEvenLength()
			let data = ERC20Encoder.encodeTransfer(to: sendToAddress, value: sendHexString).hexString
			return .init(to: contractAddress, from: from, amount: "0", dataType: .tokenTransfer, data: data.add0x)
		}
		return .init(to: sendToAddress, from: from, amount: sendAmount, dataType: .transfer, data: "0x")
	}
}

struct SendAmountView_Previews: PreviewProvider {
	static var previews: some View {
		SendAmountView(viewObject: .init(coin: .testETH, sendToAddress: ""), path: .constant(.init()))
	}
}
