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
	case Browser
	case WalletConnect
	
	var navigationTitle: String {
		switch self {
		case .Wallet:
			return "Wallet"
		case .Browser:
			return "Browser"
		case .WalletConnect:
			return "WalletConnect"
		}
	}
}

struct HomeView: View {
	@State var selectedScreen: Int = 0
	@State private var sideBarVisible = false
	@StateObject var walletVM = WalletViewModel()
	
	var coins: Array<Coin> {
		AccountManager.current?.coin?.allObjects as? Array<Coin> ?? []
	}
	
	var title: String {
		Screen.allCases[selectedScreen].navigationTitle
	}
	
	init() {
		UITabBar.appearance().isHidden = true
	}
	
	@State private var path = NavigationPath()
	
	var body: some View {
		NavigationStack(path: $path) {
			ZStack {
				Color.white.ignoresSafeArea()
				TabView(selection: $selectedScreen) {
					WalletView(path: $path)
						.tag(0)
						.environmentObject(walletVM)
						.navigationDestination(for: RouteName.self) { route in
							switch route {
							case .send(let coin):
								SendView(coin: coin, path: $path)
							case .sendAmount(let coin, let toAddress):
								SendAmountView(coin: coin, sendToAddress: toAddress, path: $path)
									.environmentObject(walletVM)
							case .receive(let coin):
								ReceiveView(coin: coin)
							case .importToken:
								ImportTokenView()
							}
						}
					
					BrowserView().tag(1)
					WalletConnectView().tag(2)
				}
				.header(
					title: title,
					leftItem: {
						Image(systemName: "line.3.horizontal")
					},
					onPressedLeftItem: toggleMenu
				)
				.padding(.top, SafeAreaUtils.top - 16)
				
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
			case .Wallet, .Browser, .WalletConnect:
				selectedScreen = item.rawValue
			case .Etherscan:
				return
			case .Logout:
				try? SecureManager.keystore.wallets.forEach { wallet in
					if let password = try SecureManager.getGenericPassowrd() {
						try SecureManager.keystore.delete(wallet: wallet, password: password)
						try SecureManager.reset()
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
