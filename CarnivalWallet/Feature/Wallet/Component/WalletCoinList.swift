//
//  WalletCoinList.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/2.
//

import SwiftUI

struct WalletCoinList: View {
	var coins: Array<Coin>

	var body: some View {
		VStack(spacing: 12) {
			ForEach(coins) { coin in
				HStack {
					CoinIconView(coin: coin, size: 48)
					VStack(alignment: .leading) {
						HStack {
							Text(coin.balance)
								.AvenirNextRegular(size: 16)
							Text(coin.symbol)
								.AvenirNextMedium(size: 16)
						}
						Text("$ \(coin.exchangeRate?.time(coin.balance ?? "") ?? "")")
							.AvenirNextRegular(size: 14)
					}
					.padding(.leading, 16)
					Spacer()
					Image(systemName: "chevron.right")
						.resizable()
						.scaledToFit()
						.frame(width: 16, height: 16)
				}
				.padding(.horizontal, 16)
				Divider()
			}
		}
		.padding(.top, 12)
	}
}

struct WalletCoinList_Previews: PreviewProvider {
	static var previews: some View {
		WalletCoinList(coins: [.testETH, .testUSDT])
	}
}
