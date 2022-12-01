//
//  CoinView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/1.
//

import SwiftUI

struct CoinView: View {
	@EnvironmentObject var navigator: NavigatorImpl
	var coin: Coin
	var body: some View {
		ZStack {
			VStack {
				VStack(spacing: 16) {
					CoinIconView(network: coin.network, contractAddress: coin.contractAddress, size: 56)
						.padding(.top, 32)
					
					Text(coin.balance, coin.symbol)
						.AvenirNextMedium(size: 32)
					
					HStack(spacing: 32) {
						BaseButton(
							text: WalletCTAType.Receive.rawValue,
							icon: WalletCTAType.Receive.icon,
							height: 48,
							style: .capsule,
							onPress: {
								navigator.navigateToRecieve(coin: coin)
							}
						)
						.foregroundColor(.white)
						
						BaseButton(
							text: WalletCTAType.Send.rawValue,
							icon: WalletCTAType.Send.icon,
							height: 48,
							style: .capsule,
							onPress: {
								navigator.navigateToSend(coin: coin)
							}
						)
						.foregroundColor(.white)
					}
					.padding(.horizontal, 32)
					
					Divider().padding(.top, 20)
				}
				Spacer()
			}
			.toolbar(.hidden)
			.header(title: coin.name ?? "Coin") {
				Image(systemName: "chevron.left")
			} onPressedLeftItem: {
				navigator.pop()
			}
		}
	}
}

struct CoinView_Previews: PreviewProvider {
	static var previews: some View {
		CoinView(coin: .testETH)
	}
}
