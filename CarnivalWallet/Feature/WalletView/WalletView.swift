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
	@Binding var path: NavigationPath
	@EnvironmentObject var vm: WalletViewModel
	
	@State var coinSelectorState: CoinSelectorState = .invisible

	var coinSelectorVisible: Binding<Bool> {
		.constant(coinSelectorState != .invisible)
	}
	
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
							}
						)
						.foregroundColor(.white)
					}
					.padding(.horizontal, 32)
					
					Divider()
						.padding(.top, 16)
					
					WalletCoinList()
						.environment(\.managedObjectContext, .defaultContext)
					
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
			}
			.safeAreaInset(.top, inset: 32)
		}
		.onAppear {
			vm.fetchBalance()
		}
		.coinSelector(isVisible: coinSelectorVisible, coins: vm.coins) { coin in
			Task {
				if (coinSelectorState == .send) {
					path.append(RouteName.send(coin))
				} else {
					path.append(RouteName.receive(coin))
				}
				coinSelectorState = .invisible
			}
		}
	}
}

struct WalletView_Previews: PreviewProvider {
	static var previews: some View {
		WalletView(path: .constant(.init()))
			.environmentObject(WalletViewModel())
	}
}
