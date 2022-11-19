//
//  WalletCoinList.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/2.
//

import SwiftUI
import BigInt

struct WalletCoinList: View {
	var coins: Array<Coin>

	var body: some View {
		VStack(spacing: 12) {
			ForEach(0 ..< coins.indices.count, id: \.self) { index in
				let vm = WalletCoinListItemViewModel(coin: coins[index])
				WalletCoinListItem(vm: vm)
			}
		}
		.padding(.top, 12)
	}
}

struct WalletCoinList_Previews: PreviewProvider {
	static var previews: some View {
		WalletCoinList(coins: [.testETH, .testETH])
	}
}
