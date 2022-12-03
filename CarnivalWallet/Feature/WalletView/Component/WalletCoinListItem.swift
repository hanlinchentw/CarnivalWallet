//
//  WalletCoinListItem.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/15.
//

import SwiftUI

struct WalletCoinListItem: View {
	var isEditing: Bool
	@ObservedObject var coin: Coin
	
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
						Text(coin.balance, " ", coin.symbol)
							.AvenirNextRegular(size: 16)
					}
					Text("$ ", (coin.fiatBalance ?? "0"))
						.AvenirNextRegular(size: 14)
				}
				.padding(.leading, 16)
				Spacer()
				Image(systemName: isEditing ? "minus.circle.fill" : "chevron.right")
					.resizable()
					.scaledToFit()
					.foregroundColor(isEditing ? Color.redNormal : Color.black)
					.frame(width: 16, height: 16)
			}
			.padding(.horizontal, 16)
			Divider()
		}
	}
}

struct WalletCoinListItem_Previews: PreviewProvider {
	static var previews: some View {
		WalletCoinListItem(isEditing: true, coin: .testETH)
	}
}
