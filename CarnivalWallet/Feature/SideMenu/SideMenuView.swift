//
//  SIdeMenuView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import SwiftUI


struct SideMenuView: View {
	let MENU_WIDTH = DeviceDimension.WIDTH * 0.83
	@Binding var visible: Bool
	var toggleMenu: () -> Void
	var tapItem: (_ item: MenuItem) -> Void
	
	var body: some View {
		ZStack {
			Color.black
				.opacity(visible ? 0.7 : 0)
				.onTapGesture {
					toggleMenu()
				}
			
			HStack {
				MenuContentView(
					onReceive: {
						
					}, onSend: {
						
					}, itemOnPress: tapItem
				)
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

struct SideMenuView_Previews: PreviewProvider {
	static var previews: some View {
		SideMenuView(visible: .constant(true), toggleMenu: {
			
		}, tapItem: { item in
			
		})
	}
}
