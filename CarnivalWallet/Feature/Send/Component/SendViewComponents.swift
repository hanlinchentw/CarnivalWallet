//
//  SendView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/28.
//

import Foundation
import SwiftUI

extension SendView {
	struct CoinInfoView: View {
		var contractAddress: String?
		var name: String?
		
		var body: some View {
			VStack {
				CoinIconView(
					network: Network.ethereum.rawValue,
					contractAddress: contractAddress,
					size: 44
				)
				
				Text(name)
					.AvenirNextMedium(size: 16)
			}
		}
	}
	
	struct FromAddressView: View {
		var accountName: String?
		var accountAddress: String?
		var balance: String?
		var symbol: String?
		
		var body: some View {
			VStack(alignment: .leading) {
				HStack {
					Text("From")
						.AvenirNextRegular(size: 16)
					Spacer()
					Text("Balance: ", balance, " ", symbol)
						.AvenirNextRegular(size: 14)
				}
				
				HStack {
					Image(name: "mouse_avatar")
						.resizable()
						.size(40)
						.cornerRadius(20)
					VStack(alignment: .leading) {
						HStack {
							Text(accountName)
								.AvenirNextMedium(size: 16)
							Text(accountAddress)
								.AvenirNextRegular(size: 14)
								.lineLimit(1)
								.truncationMode(.middle)
						}
					}
					.padding(.horizontal, 8)
					Spacer()
					Image(systemName: "chevron.down")
				}
				.height(56)
				.padding(.trailing, 8)
			}
			.padding(.top, 16)
			
		}
	}
}
