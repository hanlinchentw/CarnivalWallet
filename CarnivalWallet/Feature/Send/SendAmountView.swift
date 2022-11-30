//
//  SendAmountView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/22.
//

import SwiftUI
import WalletCore

struct SendAmountView: View {
	var coin: Coin
	var sendToAddress: String
	
	@EnvironmentObject var navigator: NavigatorImpl
	@EnvironmentObject var walletVM: WalletViewModel
	@Environment(\.presentationMode) var presentationMode
	@StateObject var vm = SendAmountViewModel()
	
	var body: some View {
		VStack {
			VStack(spacing: 16) {
				Text(coin.symbol)
					.AvenirNextMedium(size: 14)
					.foregroundColor(.white)
					.capsule(color: .black, radius: 16)
				
				TextField("0", text: $vm.sendAmount)
					.AvenirNextMedium(size: 32)
					.keyboardType(.decimalPad)
					.multilineTextAlignment(.center)
					.padding(.horizontal, 32)

				TextButton("Send Max", color: .blue) {
					vm.onPressMaxButton(coin: coin)
				}

				Text("Balance: ", coin.balance, " ", coin.symbol)
					.AvenirNextRegular(size: 14)
				if let error = vm.error {
					ErrorText(error.description, alignment: .center)
				}
			}
			Spacer()
			
			BaseButton(text: "Send", height: 56, isLoading: vm.isSendButtonLoading, style: .capsule) {
				Task {
					await vm.onPressSendButton(coin: coin, toAddress: sendToAddress)
				}
			}
			.padding(16)
		}
		.padding(.top, 90)
		.toolbar(.hidden)
		.header(title: "Amount", leftItem: {
			Image(systemName: "chevron.left")
		}, onPressedLeftItem: {
			navigator.pop()
		})
		.onReceive(TransactionNotification.Success.publisher) { _ in
			navigator.pop()
		}
		.onAppear {
			walletVM.fetchBalance()
		}
	}
}

struct SendAmountView_Previews: PreviewProvider {
	static var previews: some View {
		SendAmountView(coin: .testETH, sendToAddress: "")
	}
}
