//
//  TabView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import SwiftUI
import CoreData

enum Screen: Int, CaseIterable {
	case Wallet
	
	var navigationTitle: String {
		switch self {
		case .Wallet:
			return "Wallet"
		}
	}
}

struct HomeView: View {
	@Environment(\.managedObjectContext) var viewContext
	@EnvironmentObject var mainCoordinator: MainCoordinator
	@State var selectedScreen: Int = 0
	@State private var sideBarVisible = false
	@StateObject var walletVM = WalletViewModel()
	
	var coins: Array<Coin> {
		AccountManager.getCurrent?.coin?.allObjects as? Array<Coin> ?? []
	}
	
	var title: String {
		Screen.allCases[selectedScreen].navigationTitle
	}
	
	init() {
		UITabBar.appearance().isHidden = true
	}

	@StateObject var navigator = NavigatorImpl()

	var body: some View {
		NavigationStack(path: $navigator.path) {
			ZStack {
				Color.white.ignoresSafeArea()
				TabView(selection: $selectedScreen) {
					WalletView()
						.tag(0)
						.environment(\.managedObjectContext, .defaultContext)
						.environmentObject(walletVM)
						.environmentObject(navigator)
						.navigationDestination(for: RouteName.self) { route in
							switch route {
							case .send(let coin):
								SendView(coin: coin)
									.environmentObject(navigator)
							case .sendAmount(let coin, let toAddress):
								SendAmountView(coin: coin, sendToAddress: toAddress)
									.environmentObject(navigator)
									.environmentObject(walletVM)
							case .receive(let coin):
								ReceiveView(coin: coin)
									.environmentObject(navigator)
							case .coin(let coin):
								CoinView(coin: coin)
									.environment(\.managedObjectContext, .defaultContext)
									.environmentObject(navigator)
							case .importToken:
								ImportTokenView()
							}
						}
				}
				.header(
					title: title,
					leftItem: {
						Image("menu")
							.resizable()
					},
					onPressedLeftItem: toggleMenu,
					rightItem: {
						if selectedScreen == 0 {
							return Image("edit")
								.resizable()
						}
						return Image("")
							.resizable()
					}, onPressedRightItem: {
						withAnimation {
							walletVM.isEditing = !walletVM.isEditing
						}
					}
				)
				.padding(.top, SafeAreaUtils.top	)
				
				SideMenuView(
					visible: $sideBarVisible,
					toggleMenu: toggleMenu,
					tapItem: tapItem
				)
			}
		}
	}
	
	var toggleMenu: () -> Void {
		{
			withAnimation(.easeIn(duration: 0.4)) {
				sideBarVisible.toggle()
			}
		}
	}
	
	var tapItem: (_ item: MenuItem) -> Void {
		{ item in
			switch item {
			case .Wallet:
				selectedScreen = item.rawValue
			case .Etherscan:
				if let address = AccountManager.getCurrent?.address {
					UIApplication.shared.open(Etherscan.route.address(address).url)
				}
				return
			case .Logout:
				try? SecureManager.keystore.wallets.forEach { wallet in
					if let password = try SecureManager.getGenericPassowrd() {
						try SecureManager.keystore.delete(wallet: wallet, password: password)
						try SecureManager.reset()
						try AccountManager.deleteAll()
						mainCoordinator.logout()
					}
				}
			}
			toggleMenu()
		}
	}
}

struct TabView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
