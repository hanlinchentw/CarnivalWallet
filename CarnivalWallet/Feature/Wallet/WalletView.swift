//
//  WalletView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/16.
//

import SwiftUI

struct WalletView: View {
	var account: AccountEntity? = nil

	@State var showAddress: Bool = false
	@State var isBalanceShown: Bool = true

	var coins: Array<Coin> {
		account?.coin?.allObjects as? Array<Coin> ?? []
	}
	
	var body: some View {
		ZStack {
			Color.white
				.edgesIgnoringSafeArea(.bottom)
			
			ScrollView {
				VStack(spacing: 12) {
					HStack(spacing: 12) {
						Image("mouseAvatar")
							.resizable()
							.size(44)
							.cornerRadius(22)
						VStack(alignment: .leading, spacing: 0) {
							HStack {
								if (showAddress) {
									// TODO: Copy
									Text(account?.address)
										.foregroundColor(.black)
										.AvenirNextRegular(size: 14)
										.cornerRadius(10)
										.truncationMode(.middle)
										.lineLimit(0)
								} else {
									Text(account?.name)
										.AvenirNextBold(size: 32)
								}
								IconButton("arrow.left.arrow.right") {
									withAnimation {
										showAddress.toggle()
									}
								}
								.foregroundColor(.black)
								.frame(width: 16, height: 16)
							}
						}
						Spacer()
					}
					.padding(.horizontal, 20)
					
					VStack {
						HStack {
							Text("your total balance")
								.AvenirNextRegular(size: 16)
							IconButton(isBalanceShown ? "eye.slash" : "eye") {
								withAnimation {
									isBalanceShown.toggle()
								}
							}
							.size(20)
							.foregroundColor(.black)
							Spacer()
						}
						HStack {
							Text(isBalanceShown ? "$***" : "$170.56")
								.AvenirNextBold(size: 48)
							Spacer()
						}
					}
					.padding(.horizontal, 20)
					.padding(.vertical, 16)
					
					HStack(spacing: 32) {
						
						Button {
							//TODO: receive page
						} label: {
							HStack {
								Image(systemName: "arrow.down.to.line")
									.resizable()
									.aspectRatio(contentMode: .fit)
									.frame(height: 18)
								Text("Receive")
									.AvenirNextMedium(size: 14)
							}
							.foregroundColor(.white)
						}
						.padding(.vertical, 16)
						.width(150)
						.background(.blue)
						.cornerRadius(28)
						
						Button {
							//TODO: receive page
						} label: {
							HStack {
								Image(systemName: "arrow.up.right")
									.resizable()
									.aspectRatio(contentMode: .fit)
									.frame(height: 18)
								Text("Send")
									.AvenirNextMedium(size: 14)
							}
							.foregroundColor(.white)
						}
						.padding(.vertical, 16)
						.width(150)
						.background(.blue)
						.cornerRadius(28)
					}
					

					Divider()
						.padding(.top, 16)
					
					ForEach(coins) { coin in
						HStack {
							CoinIconView(coin: coin, size: 48)
							VStack(alignment: .leading) {
								HStack {
									Text(coin.balance)
										.AvenirNextRegular(size: 16)
									Text(coin.symbol)
										.AvenirNextMedium(size: 16)
								}
								Text("$ \(coin.exchangeRate?.time(coin.balance ?? "") ?? "")")
									.AvenirNextRegular(size: 14)
							}
							.padding(.leading, 16)
							
							Spacer()
							
							Image(systemName: "chevron.right")
								.resizable()
								.scaledToFit()
								.frame(width: 16, height: 16)
						}
						Divider()
					}
					.padding(.horizontal, 16)
					
					Text("Don't see your tokens?")
						.AvenirNextMedium(size: 16)
					TextButton("Import Tokens") {
						
					}
					.foregroundColor(.blue)
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
