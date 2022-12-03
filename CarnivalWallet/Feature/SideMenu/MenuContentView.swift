//
//  MenuContentView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import SwiftUI

struct MenuContentView: View {
	var account: AccountEntity? {
		AccountManager.getCurrent
	}
	var itemOnPress: (_ item: MenuItem) -> Void
	
	var body: some View {
		ZStack {
			VStack(alignment: .leading) {
				HStack(alignment: .bottom) {
					Image("carnival")
						.resizable()
						.scaledToFit()
						.size(24)
					Text("Carnival")
						.AvenirNextBold(size: 16)
				}
				.padding(.leading, 16)
				
				
				AccountInfoView(
					name: account?.name,
					balance: account?.totalFiatBalance,
					address: account?.address
				)
				.padding(.top, 12)
				.padding(.leading, 16)
	
				MenuListView(itemOnPress: itemOnPress)
				
				Spacer()
			}
			.padding(.top, 64)
		}
	}
}

struct MenuContentView_Previews: PreviewProvider {
	static var previews: some View {
		MenuContentView(
		 itemOnPress: { item in
				
			}
		)
	}
}
