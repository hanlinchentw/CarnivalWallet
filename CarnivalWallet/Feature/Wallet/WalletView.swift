//
//  WalletView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/16.
//

import SwiftUI

struct WalletView: View {
	var account: AccountEntity? = nil
	
	
	
	var coins: Array<Coin> {
		account?.coin?.allObjects as? Array<Coin> ?? []
	}
	
	var body: some View {
		ZStack {
			Color.white
				.edgesIgnoringSafeArea(.bottom)
			
			ScrollView {
				VStack(spacing: 0) {
					WalletInfoView(
						address: account?.address,
						name: account?.name
					)
					
					WalletFiatBalanceView(balance: "170.56")
					
					HStack(spacing: 32) {
						WalletCTAButton(type: .Receive)
						WalletCTAButton(type: .Send)
					}
					
					Divider()
						.padding(.top, 16)
					
					WalletCoinList(coins: coins)
					
					VStack {
						Text("Don't see your tokens?")
							.AvenirNextMedium(size: 16)
						TextButton("Import Tokens") {
							// TODO: 添加 Token
						}
						.foregroundColor(.blue)
					}
					.padding(.top, 16)
				}
			}
			.padding(.top, 32)
		}
	}
}

struct WalletView_Previews: PreviewProvider {
	static var previews: some View {
		WalletView(account: .testEthAccountEntity)
	}
}
