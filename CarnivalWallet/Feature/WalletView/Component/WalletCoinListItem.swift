//
//  WalletCoinListItem.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/15.
//

import SwiftUI

struct WalletCoinListItem: View {
	var vm: WalletCoinListItemViewModel
	var body: some View {
		VStack {
			HStack {
				CoinIconView(
					network: vm.network,
					contractAddress: vm.contractAddress,
					size: 48
				)
				VStack(alignment: .leading) {
					HStack {
						Text(vm.balance, vm.symbol)
							.AvenirNextRegular(size: 16)
					}
					Text("$\(150)")
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
		WalletCoinListItem(vm: .init(coin: .testETH))
	}
}
