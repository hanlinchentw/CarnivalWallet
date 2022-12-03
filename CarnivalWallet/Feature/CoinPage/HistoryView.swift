//
//  HistoryView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/3.
//

import SwiftUI

struct HistoryView: View {
	var coin: Coin
	var transactions: FetchedResults<History>

	var account: AccountEntity {
		AccountManager.getCurrent!
	}

	var body: some View {
		VStack(spacing: 20) {
			ForEach(transactions) {
				let presenter = HistoryPresenter(coin: coin, transaction: $0)
				Link(destination: Etherscan.route.transaction($0.txHash!).url) {
					HStack(spacing: 16) {
						Image(systemName: presenter.iconString)
							.resizable()
							.size(24)
							.foregroundColor(.blue)
						VStack(alignment: .leading) {
							Text(presenter.title)
								.AvenirNextMedium(size: 16)
							Text(presenter.subTitle)
								.AvenirNextRegular(size: 16)
								.foregroundColor(presenter.subTitleColor)
						}
						Spacer()
						Text(presenter.amount)
							.AvenirNextMedium(size: 16)
					}
				}
				.buttonStyle(.plain)
				.padding(.horizontal, 16)
				
				Divider()
			}
			
			if let address = account.address {
				Link(destination: Etherscan.route.address(address).url) {
					Text("View all on Etherscan")
						.AvenirNextMedium(size: 16)
				}
			}
		}
		.padding(.top, 16)
	}
}
