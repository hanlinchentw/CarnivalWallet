//
//  MenuListView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/5.
//

import SwiftUI

struct MenuListView: View {
	var itemOnPress: (_ item: MenuItem) -> Void

	var body: some View {
		ForEach(MenuSection.allCases, id: \.id) { section in
			Divider()
			ForEach(section.items, id: \.id) { item in
				Button {
					itemOnPress(item)
				} label: {
					HStack(spacing: 12) {
						Image(name: item.imageName)
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 24, height: 24)
						Text(item.title)
							.AvenirNextRegular(size: 16)
					}
					.foregroundColor(.black)
				}
				.listRowBackground(Color.white)
				.listRowSeparator(.hidden)
			}
			.padding(.leading, 16)
		}
	}
}

struct MenuListView_Previews: PreviewProvider {
	static var previews: some View {
		MenuListView { item in
			
		}
	}
}
