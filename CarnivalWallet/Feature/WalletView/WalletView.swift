//
//  WalletView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/16.
//

import SwiftUI
import CoreData

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

enum CoinSelectorState: Int {
	case send
	case receive
	case invisible
}

struct WalletView: View {
	@EnvironmentObject var vm: WalletViewModel
	@EnvironmentObject var navigator: NavigatorImpl
	
	@State var sendCoin: Coin?
	@State var receiveCoin: Coin?
	@State var coinSelectorState: CoinSelectorState = .invisible
	@State var coinSelectorVisible: Bool = false
	
	var body: some View {
		ZStack {
			Color.white
				.edgesIgnoringSafeArea(.bottom)
			
			ScrollView {
				VStack(spacing: 0) {
					WalletInfoView(
						address: vm.accountAddress,
						name: vm.accountName
					)

					WalletFiatBalanceView(balance: vm.accountBalance ?? "0")
					
					HStack(spacing: 32) {
						BaseButton(
							text: WalletCTAType.Receive.rawValue,
							icon: WalletCTAType.Receive.icon,
							height: 48,
							style: .capsule,
							onPress: {
								coinSelectorState = .receive
								coinSelectorVisible = true
							}
						)
						.foregroundColor(.white)
						
						BaseButton(
							text: WalletCTAType.Send.rawValue,
							icon: WalletCTAType.Send.icon,
							height: 48,
							style: .capsule,
							onPress: {
								coinSelectorState = .send
								coinSelectorVisible = true
							}
						)
						.foregroundColor(.white)
					}
					.padding(.horizontal, 32)
					
					Divider()
						.padding(.top, 16)
					
						WalletCoinList(
							isEditing: vm.isEditing,
							onPressItem: { coin in
								if vm.isEditing {
									vm.deleteCoin(coin)
									return
								}
								navigator.navigateToCoin(coin: coin)
								
							}
						).environment(\.managedObjectContext, .defaultContext)
					
					VStack(spacing: 6) {
						Text("Don't see your token?")
							.AvenirNextMedium(size: 16)
						NavigationLink(value: RouteName.importToken) {
							Text("Import Tokens")
								.AvenirNextMedium(size: 14)
								.foregroundColor(.blue)
						}
					}
					.padding(.top, 16)
				}
			}
			.refreshable {
				vm.fetchBalance()
				vm.fetchExchangeRate()
			}
			.safeAreaInset(.top, inset: 32)
		}
		.onAppear {
			vm.fetchBalance()
			vm.fetchExchangeRate()
		}
		.coinSelector(isVisible: $coinSelectorVisible, coins: vm.coins) { coin in
			Task {
				coinSelectorVisible = false
				if (coinSelectorState == .send) {
					sendCoin = coin
				} else {
					receiveCoin = coin
				}
			}
		}
		.onReceive(sendCoin.publisher) { _ in
			if let sendCoin {
				navigator.navigateToSend(coin: sendCoin)
				self.sendCoin = nil
			}
		}
		.onReceive(receiveCoin.publisher) { _ in
			if let receiveCoin {
				navigator.navigateToRecieve(coin: receiveCoin)
				self.receiveCoin = nil
			}
		}
	}
}

struct WalletView_Previews: PreviewProvider {
	static var previews: some View {
		WalletView()
			.environmentObject(WalletViewModel())
			.environmentObject(NavigatorImpl())
	}
}
