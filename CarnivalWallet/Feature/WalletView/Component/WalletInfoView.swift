//
//  WalletInfoView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/2.
//

import SwiftUI

struct WalletInfoView: View {
	var address: String?
	var name: String?
	
	var body: some View {
		HStack(spacing: 12) {
			Image("mouseAvatar")
				.resizable()
				.size(44)
				.cornerRadius(22)
			VStack(alignment: .leading, spacing: 0) {
				Text(name)
					.AvenirNextBold(size: 26)
				Text(address)
					.foregroundColor(.black)
					.AvenirNextRegular(size: 13)
					.cornerRadius(10)
					.truncationMode(.middle)
					.lineLimit(0)
					.width(100)
			}
			Spacer()
		}
		.padding(.horizontal, 20)
	}
}

struct WalletInfoView_Previews: PreviewProvider {
	static var previews: some View {
		WalletInfoView(address: "0xdAC17F958D2ee523a2206206994597C13D831ec7", name: "Wallet 1")
	}
}
