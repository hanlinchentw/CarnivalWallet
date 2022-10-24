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
	@State private var selection: Int = 0
	@State private var sideBarVisible = false
	
	var body: some View {
		ZStack {
			NavigationView {
				TabView(selection: $selection) {
					WalletView().tag(0)
					BrowserView().tag(1)
					WalletConnectView().tag(2)
				}
				.navigationTitle(Screen.allCases[selection].navigationTitle)
				.navigationBarTitleDisplayMode(.inline)
				.toolbar {
					ToolbarItemGroup(placement: .navigationBarLeading) {
						Button(action: toggleMenu, label: {
							Image(systemName: "line.3.horizontal")
						})
						.foregroundColor(.black)
					}
				}
			}
			SideMenuView(visible: $sideBarVisible, toggleMenu: toggleMenu, tapItem: tapItem)
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
