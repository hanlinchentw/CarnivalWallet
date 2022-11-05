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
	var onLogout: () -> Void
	
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
						onLogout()
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
}

struct MenuContentView_Previews: PreviewProvider {
	static var previews: some View {
		let menuItems = MenuItem.allCases
		MenuContentView(menuItems: menuItems, itemOnPress: { item in
			
		}, onLogout: {
			
		})
	}
}
