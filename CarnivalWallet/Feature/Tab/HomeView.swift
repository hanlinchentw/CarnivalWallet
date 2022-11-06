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
	@EnvironmentObject var coordinator: MainCoordinator
	@State private var selection: Int = 0
	@State private var sideBarVisible = false
	@StateObject var accountVM = AccountViewModel()

	init() {
		let titleColor = UIColor.black
		let coloredAppearance = UINavigationBarAppearance()
		coloredAppearance.backgroundColor = .white
		coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor]
		UINavigationBar.appearance().standardAppearance = coloredAppearance
		UINavigationBar.appearance().compactAppearance = coloredAppearance
		UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
		UINavigationBar.appearance().tintColor = titleColor
	}
	
	var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()
			
			NavigationView {
				TabView(selection: $selection) {
					WalletView()
						.tag(0)
						.environmentObject(accountVM)
					BrowserView().tag(1)
					WalletConnectView().tag(2)
				}
				.navigationTitle(Screen.allCases[selection].navigationTitle)
				.navigationBarTitleDisplayMode(.inline)
				.navbarLeftItem(item: {
					Button(action: toggleMenu, label: {
						Image(systemName: "line.3.horizontal")
							.foregroundColor(.black)
					})
				})
			}
			SideMenuView(
				visible: $sideBarVisible,
				toggleMenu: toggleMenu,
				tapItem: tapItem
			)
			.environmentObject(accountVM)
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
				selection = 0
			case .Browser:
				selection = 1
			case .WalletConnect:
				selection = 2
			case .Etherscan:
				return
			case .Logout:
				try? SecureManager.keystore.wallets.forEach { wallet in
					if let password = try SecureManager.getGenericPassowrd() {
						try SecureManager.keystore.delete(wallet: wallet, password: password)
						try SecureManager.reset()
						coordinator.setup()
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
			.environmentObject({() -> AccountViewModel in
				return Mock_AccountViewModel()
			}())
	}
}
