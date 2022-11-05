//
//  SIdeMenuView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import SwiftUI

enum MenuItem: Int, CaseIterable, Identifiable {
	case Wallet = 0
	case Browser
	case WalletConnect
	
	var title: String {
		switch self {
		case .Wallet:
			return "Wallet"
		case .Browser:
			return "Browser"
		case .WalletConnect:
			return "WalletConnect"
		}
	}
	
	var imageName: String {
		switch self {
		case .Wallet:
			return "wallet"
		case .Browser:
			return "network"
		case .WalletConnect:
			return "wc_logo_black"
		}
	}
	
	var id: Int {
		hashValue
	}
}

struct SideMenuView: View {
	let MENU_WIDTH = DeviceDimension.WIDTH * 0.85
	@Binding var visible: Bool
	var toggleMenu: () -> Void
	var tapItem: (_ item: MenuItem) -> Void
	var onLogout: () -> Void

	var body: some View {
		ZStack {
			Color.black
				.opacity(visible ? 0.7 : 0)
				.onTapGesture {
					toggleMenu()
				}

			HStack {
				MenuContentView(menuItems: MenuItem.allCases, itemOnPress: tapItem, onLogout: onLogout)
					.width(MENU_WIDTH)
					.height(DeviceDimension.HEIGHT)
					.background(.white)
				Spacer()
			}
			.offset(.init(width: visible ? 0 : -MENU_WIDTH, height: 0))
		}
		.zIndex(2)
		.ignoresSafeArea()
	}
}

struct SIdeMenuView_Previews: PreviewProvider {
	static var previews: some View {
		SideMenuView(visible: .constant(true), toggleMenu: {
			
		}, tapItem: { item in
			
		}, onLogout: {
			
		})
	}
}
