//
//  MenuContentView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import SwiftUI

struct MenuContentView: View {
	var currentAccount: AccountEntity? {
		AccountManager.shared.currentAccount
	}

	var onReceive: () -> Void
	var onSend: () -> Void
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
					name: currentAccount?.name,
					balance: currentAccount?.fiatBalance,
					address: currentAccount?.address
				)
				.padding(.top, 12)
				.padding(.leading, 16)
				
				Divider()
					.padding(.top, 12)
				
				TwoHorizontalButtons
					.padding(.vertical, 6)
					.padding(.horizontal, 32)
				
				MenuListView(itemOnPress: itemOnPress)
				
				Spacer()
			}
			.padding(.top, 64)
		}
	}
	
	var TwoHorizontalButtons: some View {
		HStack(spacing: 16) {
			BaseButton(
				text: WalletCTAType.Receive.rawValue,
				icon: WalletCTAType.Receive.icon,
				height: 40,
				style: .outline,
				onPress: {
					
				}
			)
			BaseButton(
				text: WalletCTAType.Send.rawValue,
				icon: WalletCTAType.Send.icon,
				height: 40,
				style: .outline,
				onPress: {
					
				}
			)
		}
	}
}

struct MenuContentView_Previews: PreviewProvider {
	static var previews: some View {
		MenuContentView(
			onReceive: {
				
			}, onSend: {
				
			}, itemOnPress: { item in
				
			}
		)
	}
}
