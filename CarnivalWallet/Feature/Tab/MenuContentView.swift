//
//  MenuContentView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import SwiftUI

struct MenuContentView: View {
	var menuItems: Array<MenuItem>
	var itemOnPress: (_ item: MenuItem) -> Void
	var body: some View {
		VStack {
			List {
				Section(content: {
					ForEach(menuItems, id: \.id) { item in
						Button {
							itemOnPress(item)
						} label: {
							HStack {
								Image(item.imageName)
									.resizable()
									.aspectRatio(contentMode: .fit)
									.frame(width: 24, height: 24)
								Text(item.title)
							}
							.foregroundColor(.black)
						}
						.listRowBackground(Color.white)
					}
				})
				HStack {
					Spacer()
					Button {
						deleteWallet()
					} label: {
						Image(systemName: "rectangle.portrait.and.arrow.right")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 24, height: 24)
							.foregroundColor(.black)
					}
					Spacer()
				}
				.listRowBackground(Color.clear)
				.listRowSeparator(.hidden)
			}
			
			.listStyle(.grouped)
		}
	}
	
	func deleteWallet() {
		try? SecureManager.keystore.wallets.forEach { wallet in
			print("wallet: \(wallet)")
			if let password = try SecureManager.getGenericPassowrd() {
				print("password: \(password)")
				try SecureManager.reset()
			}
		}
	}
}

struct MenuContentView_Previews: PreviewProvider {
	static var previews: some View {
		let menuItems = MenuItem.allCases
		MenuContentView(menuItems: menuItems) { item in
			
		}
	}
}
