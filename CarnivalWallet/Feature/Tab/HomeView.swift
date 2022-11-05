//
//  TabView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import SwiftUI

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
			Color.white
				.ignoresSafeArea()
			
			NavigationView {
				TabView(selection: $selection) {
					WalletView(account: accountVM.currentAccount).tag(0)
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
				tapItem: tapItem,
				onLogout: onLogout
			)
		}
	}
	
	var onLogout: VoidClosure {
		{
			try? SecureManager.keystore.wallets.forEach { wallet in
				
				if let password = try SecureManager.getGenericPassowrd() {
					print("password >>> \(password)")
					try SecureManager.keystore.delete(wallet: wallet, password: password)
					try SecureManager.reset()
					coordinator.setup()
				}
			}
			
		}
	}
	
	var toggleMenu: () -> Void {
		{
			withAnimation(.easeInOut(duration: 0.4)) {
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
