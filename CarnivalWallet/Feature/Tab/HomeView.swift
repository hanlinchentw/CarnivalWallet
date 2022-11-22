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
	@EnvironmentObject var coordinator: HomeCoordinator
	@State private var sideBarVisible = false
	
	var title: String {
		Screen.allCases[coordinator.selectedScreen].navigationTitle
	}
	
	init() {
		UITabBar.appearance().isHidden = true
	}

	var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()
			TabView(selection: $coordinator.selectedScreen) {
				coordinator.startWalletView().tag(0)
				BrowserView().tag(1)
				WalletConnectView().tag(2)
			}
			.header(
				title: title,
				leftItem: {
					Image(systemName: "line.3.horizontal")
				},
				onPressedLeftItem: toggleMenu,
				rightItem: {
					Image(systemName: "plus")
				},
				onPressedRightItem: {
					coordinator.addToken()
				}
			)
			.padding(.top, SafeAreaUtils.top)
			SideMenuView(
				visible: $sideBarVisible,
				toggleMenu: toggleMenu,
				tapItem: tapItem
			)
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
				coordinator.switchScreen(screenIndex: item.rawValue)
			case .Etherscan:
				return
			case .Logout:
				try? SecureManager.keystore.wallets.forEach { wallet in
					if let password = try SecureManager.getGenericPassowrd() {
						try SecureManager.keystore.delete(wallet: wallet, password: password)
						try SecureManager.reset()
						//						coordinator.setup()
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
			.environmentObject({() -> HomeCoordinator in
				return HomeCoordinator(navigationController: .init())
			}())
	}
}
