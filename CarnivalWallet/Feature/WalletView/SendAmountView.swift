//
//  SendAmountView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/22.
//

import SwiftUI

struct SendAmountView: View {
	@ObservedObject var coordinator: SendCoordinator
	
	var body: some View {
		VStack {
			VStack(spacing: 16) {
				Text(coordinator.sendCoin.symbol)
					.AvenirNextMedium(size: 14)
					.foregroundColor(.white)
					.capsule(color: .black, radius: 16)
				
				TextField("0", text: $coordinator.sendAmount)
					.AvenirNextMedium(size: 32)
					.keyboardType(.decimalPad)
					.multilineTextAlignment(.center)
					.fixedSize()
					.padding(.horizontal, 16)
				TextButton("Send Max", color: .blue) {
					coordinator.sendAmount = coordinator.sendCoin.balance ?? ""
				}
				Text("Balance: ", coordinator.sendCoin.balance, " ", coordinator.sendCoin.symbol)
					.AvenirNextRegular(size: 14)
			}
			Spacer()
			
			BaseButton(text: "Send", height: 56, disabled: false, style: .capsule) {
				coordinator.doTransaction()
			}
			.padding(16)
		}
		.padding(.top, 90)
		.header(title: "Amount", leftItem: {
			Image(systemName: "chevron.left")
		}, onPressedLeftItem: {
			coordinator.goBack()
		})
	}
}

struct SendAmountView_Previews: PreviewProvider {
	static var previews: some View {
		SendAmountView(coordinator: .init(coin: .testUSDT, navigationController: .init()))
	}
}
