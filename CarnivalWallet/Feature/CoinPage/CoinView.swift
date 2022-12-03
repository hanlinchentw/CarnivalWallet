//
//  CoinView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/1.
//

import SwiftUI

struct CoinView: View {
	var coin: Coin
	@Environment(\.managedObjectContext) var viewContext
	@FetchRequest(sortDescriptors: []) var transactions: FetchedResults<History>
	
	@EnvironmentObject var navigator: NavigatorImpl
	@StateObject var vm = HistoryViewModel()

	var body: some View {
		ZStack {
			VStack {
				ScrollView {
					VStack(spacing: 16) {
						CoinIconView(network: coin.network, contractAddress: coin.contractAddress, size: 56)
							.padding(.top, 32)
						
						Text(coin.balance, " ", coin.symbol)
							.AvenirNextMedium(size: 32)
							.minimumScaleFactor(0.5)
							.lineLimit(0)
							.padding(.horizontal, 32)
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
					
					HistoryView(coin: coin, transactions: transactions)
					
					Spacer()
				}
				.safeAreaInset(.bottom, inset: 32)
				.refreshable {
					await vm.fetchTransaction(skipConfirmed: false)
				}
			}
			.toolbar(.hidden)
			.header(title: coin.name ?? "Coin") {
				Image(systemName: "chevron.left")
			} onPressedLeftItem: {
				navigator.pop()
			}
			.edgesIgnoringSafeArea(.bottom)
		}
		.task {
			await vm.fetchTransaction(skipConfirmed: true)
		}
	}
}

struct CoinView_Previews: PreviewProvider {
	static var previews: some View {
		CoinView(coin: .testETH)
	}
}
