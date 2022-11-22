//
//  CoinSelectorSheet.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/22.
//

import SwiftUI

//class CoinSelectorViewModel: Obse
struct CoinSelectorSheet: View {
	var coins: Array<Coin> = []
	var onPressItem: (_ coin: Coin) -> Void
	
	var body: some View {
		VStack {
			ScrollView {
				ForEach(0 ..< coins.indices.count, id: \.self) { index in
					let coin = coins[index]
					Button {
						onPressItem(coin)
					} label: {
						HStack {
							CoinIconView(network: coin.network, contractAddress: coin.contractAddress, size: 44)
							Text(coin.symbol)
								.AvenirNextMedium(size: 17)
								.padding(.horizontal, 8)
							Spacer()
							Image(systemName: "chevron.right")
								.size(17)
						}
						.foregroundColor(.black)
					}
					.padding(16)
					.presentationDetents([.medium, .large])
				}
			}
		}
	}
}

struct CoinSelectorSheet_Previews: PreviewProvider {
	static var previews: some View {
		CoinSelectorSheet(coins: [.testUSDT]) { _ in
			
		}
	}
}

extension View {
	func coinSelector(isVisible: Binding<Bool>, coins: Array<Coin>, onPressItem: @escaping (_ coin: Coin) -> Void) -> some View{
		return self.sheet(isPresented: isVisible) {
			CoinSelectorSheet(coins: coins, onPressItem: onPressItem)
		}
	}
}
	
