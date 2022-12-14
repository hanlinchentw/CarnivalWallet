//
//  WalletCoinList.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/2.
//

import SwiftUI
import BigInt
import Defaults

struct WalletCoinList: View {
	var isEditing: Bool
	var onPressItem: (Coin) -> Void
	
	@Environment(\.managedObjectContext) var viewContext
	@FetchRequest(sortDescriptors: []) var coins: FetchedResults<Coin>
	@FetchRequest(
		sortDescriptors: [],
		predicate: .init(format: "%K = %@", "index", Defaults[.accountIndex].toString())
	) var account: FetchedResults<AccountEntity>
	
	var currentAccountCoins: Array<Coin> {
		return account.first?.coin?.toArray(Coin.self)
			.sorted(by: { $0.fiatBalance ?? "0" > $1.fiatBalance ?? "0" })
		?? []
	}
	
	var body: some View {
		VStack(spacing: 12) {
			ForEach(0 ..< currentAccountCoins.indices.count, id: \.self) { index in
				let coin = currentAccountCoins[index]
				WalletCoinListItem(isEditing: isEditing, coin: coin)
					.onTapGesture {
						onPressItem(coin)
					}
			}
		}
		.padding(.top, 12)
	}
}

struct WalletCoinList_Previews: PreviewProvider {
	static var previews: some View {
		WalletCoinList(isEditing: false, onPressItem: { _ in
			
		})
	}
}
