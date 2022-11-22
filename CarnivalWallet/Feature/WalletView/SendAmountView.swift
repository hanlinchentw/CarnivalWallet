//
//  SendAmountView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/22.
//

import SwiftUI

struct SendAmountView: View {
	var coordinator: SendCoordinator
	
	@State var useMax: Bool = false
	@State var sendAmount = ""

	var body: some View {
		VStack {
			VStack(spacing: 16) {
				Button {
					
				} label: {
					HStack {
						Text(coordinator.coin.symbol)
							.AvenirNextMedium(size: 14)
						Image(systemName: "chevron.down")
					}
					.foregroundColor(.white)
				}
				.padding()
				.background(Color.black)
				.height(32)
				.cornerRadius(16)

				TextField("0", text: $sendAmount)
					.AvenirNextMedium(size: 32)
					.keyboardType(.decimalPad)
					.multilineTextAlignment(.center)
					.fixedSize()
					.padding(.horizontal, 16)
				TextButton("Send Max", color: .blue) {
					sendAmount = coordinator.coin.balance ?? ""
				}
				Text("Balance: ", coordinator.coin.balance, " ", coordinator.coin.symbol)
					.AvenirNextRegular(size: 14)
			}
			Spacer()

			BaseButton(text: "Send", height: 56, disabled: false, style: .capsule) {
				
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
