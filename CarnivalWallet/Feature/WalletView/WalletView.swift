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
								coordinator.sendToken()
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
