//
//  WalletCoinListItem.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/15.
//

import SwiftUI

struct WalletCoinListItem: View {
	@ObservedObject var coin: Coin

	var fiatBalance: String {
		let exchangeRate = coin.exchangeRate?.toDouble() ?? 0.0
		let balance = coin.balance?.toDouble() ?? 0.0
		let fiatBalance = exchangeRate * balance
		return fiatBalance.toString()
	}

	var body: some View {
		VStack {
			HStack {
				CoinIconView(
					network: coin.network,
					contractAddress: coin.contractAddress,
					size: 48
				)
				VStack(alignment: .leading) {
					HStack {
						Text(coin.balance, coin.symbol)
							.AvenirNextRegular(size: 16)
					}
					Text("$\(fiatBalance)")	
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
}

struct WalletCoinListItem_Previews: PreviewProvider {
	static var previews: some View {
		WalletCoinListItem(coin: .testETH)
	}
}
