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

struct WalletView: View {
	@EnvironmentObject var coordinator: HomeCoordinator
	@StateObject var vm = WalletViewModel()
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
							fillColor: .blue,
							height: 48,
							style: .capsule,
							onPress: {
								
							}
						)
						.foregroundColor(.white)
						
						BaseButton(
							text: WalletCTAType.Send.rawValue,
							icon: WalletCTAType.Send.icon,
							fillColor: .blue,
							height: 48,
							style: .capsule,
							onPress: {
								vm.coinSheetVisible = true
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
						Button {
							coordinator.addToken()
						} label: {
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
		.sheet(isPresented: $vm.coinSheetVisible) {
			VStack {
				ScrollView {
					ForEach(0 ..< vm.coins.indices.count, id: \.self) { index in
						let coin = vm.coins[index]
						Button {
							Task {
								vm.coinSheetVisible = false
								try? await Task.sleep(seconds: 0.10)
								coordinator.sendToken(coin: coin)
							}
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
					}
				}
			}
			.presentationDetents([.medium, .large])
		}
	}
}

struct WalletView_Previews: PreviewProvider {
	static var previews: some View {
		WalletView()
			.environmentObject({() -> WalletCoordinator in
				return WalletCoordinator(navigationController: .init())
			}())
	}
}
