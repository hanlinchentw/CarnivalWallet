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
		List {
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
			}
		}
		.listStyle(.grouped)
		.listRowInsets(.init(top: 100, leading: 0, bottom: 0, trailing: 0))
		
	}
}

struct MenuContentView_Previews: PreviewProvider {
	static var previews: some View {
		let menuItems = MenuItem.allCases
		MenuContentView(menuItems: menuItems) { item in
			
		}
	}
}
