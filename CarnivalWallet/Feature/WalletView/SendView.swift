//
//  SendView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/21.
//

import SwiftUI

struct SendView: View {
	var coordinator: SendCoordinator
	@State var sendToAddress = ""
	
	var account: AccountEntity {
		AccountManager.current!
	}
	
	var balance: String? {
		let coins = account.coin?.toArray(Coin.self) ?? []
		let eth = coins.last(where: { $0.symbol == "ETH" })
		return eth?.balance
	}
	
	@State var selectedCoin: Coin? = nil
	
	var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()
			VStack {
				ScrollView {
					VStack(alignment: .center) {
						VStack {
							CoinIconView(
								network: Network.ethereum.rawValue,
								contractAddress: coordinator.coin.contractAddress,
								size: 44
							)
							
							Text(coordinator.coin.name)
								.AvenirNextMedium(size: 16)
						}
						.padding(.top, 32)

						VStack(alignment: .leading) {
							HStack {
								Text("From")
									.AvenirNextRegular(size: 16)
								Spacer()
								Text("Balance: ", coordinator.coin.balance, " ", coordinator.coin.symbol)
									.AvenirNextRegular(size: 14)
							}

							HStack {
								Image(name: "mouse_avatar")
									.resizable()
									.size(40)
									.cornerRadius(20)
								VStack(alignment: .leading) {
									HStack {
										Text(account.name)
											.AvenirNextMedium(size: 16)
										Text(account.address)
											.AvenirNextRegular(size: 14)
											.lineLimit(1)
											.truncationMode(.middle)
									}
								}
								.padding(.horizontal, 8)
								
								
								Spacer()
								Image(systemName: "chevron.down")
							}
							.height(56)
							.padding(.trailing, 8)
						}
							.padding(.top, 16)
						
						VStack(alignment: .leading) {
							TokenAddressTextField(
								title: "To",
								placeholder: "Public address 0x...",
								text: $sendToAddress,
								hideReturnButton: true
							) { text in
								
							} onClickScanButton: {
								
							}
						}
						.padding(.top, 16)
					}
				}
				Spacer()
				BaseButton(text: "Next", height: 56, disabled: sendToAddress.isEmpty, style: .capsule) {
					coordinator.confirmAmount()
				}
			}
			.padding(.top, 16)
			.padding(.horizontal, 20)
			.header(title: "Send to") {
				Image(systemName: "xmark")
			} onPressedLeftItem: {
				coordinator.goBack()
			}
		}
		.onAppear {
			self.selectedCoin = account.coin!.toArray(Coin.self)[0]
		}
	}
}

struct SendView_Previews: PreviewProvider {
	static var previews: some View {
		SendView(coordinator: .init(coin: .testETH, navigationController: .init()))
	}
}
