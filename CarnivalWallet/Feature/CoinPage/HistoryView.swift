//
//  HistoryView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/3.
//

import SwiftUI

struct HistoryView: View {
	var coin: Coin
	var transactions: Array<History>
	
	var body: some View {
		ScrollView {
			VStack(spacing: 20) {
				ForEach(transactions) {
					let presenter = HistoryPresenter(coin: coin, transaction: $0)
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
								.foregroundColor(.greenDark)
						}
						Spacer()
						Text(presenter.amount)
							.AvenirNextMedium(size: 16)
					}
					.padding(.horizontal, 16)
					Divider()
					
				}
			}
		}
		.safeAreaInset(.bottom, inset: 32)
		.safeAreaInset(.top, inset: 16)
	}
}

struct HistoryView_Previews: PreviewProvider {
	static var previews: some View {
		HistoryView(coin: .testETH, transactions: Array(repeating: History.testHistory, count: 30))
	}
}
