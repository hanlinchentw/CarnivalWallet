//
//  WalletView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/16.
//

import SwiftUI

enum WalletCTAType: String {
	case Receive = "Receive"
	case Send = "Send"
	
	var icon: String {
		switch self {
		case .Receive: return "arrow.down.to.line"
		case .Send: return "arrow.up.right"
		}
	}
}
struct WalletView: View {
	var account: AccountEntity? = nil
	var coins: Array<Coin> {
		account?.coin?.allObjects as? Array<Coin> ?? []
	}
	
	var body: some View {
		ZStack {
			Color.white
				.edgesIgnoringSafeArea(.bottom)
			
			ScrollView {
				VStack(spacing: 0) {
					WalletInfoView(
						address: account?.address,
						name: account?.name
					)
					
					WalletFiatBalanceView(balance: "170.56")
					
					HStack(spacing: 32) {
						BaseButton(
							text: WalletCTAType.Receive.rawValue,
							icon: WalletCTAType.Receive.icon,
							fillColor: .blue,
							height: 48,
							style: .capsule,
							onPress: {
								
							}
						)
						.foregroundColor(.white)

						BaseButton(
							text: WalletCTAType.Send.rawValue,
							icon: WalletCTAType.Send.icon,
							fillColor: .blue,
							height: 48,
							style: .capsule,
							onPress: {
								
							}
						)
						.foregroundColor(.white)
					}
					.padding(.horizontal, 32)
					
					Divider()
						.padding(.top, 16)
					
					WalletCoinList(coins: coins)
					
					VStack(spacing: 6) {
						Text("Don't see your token?")
							.AvenirNextMedium(size: 16)
						TextButton("Import Tokens") {
							// TODO: 添加 Token
						}
						.foregroundColor(.blue)
					}
					.padding(.top, 16)
				}
			}
			.safeAreaInset(.top, inset: 32)
		}
	}
}

struct WalletView_Previews: PreviewProvider {
	static var previews: some View {
		WalletView(account: .testEthAccountEntity)
	}
}
