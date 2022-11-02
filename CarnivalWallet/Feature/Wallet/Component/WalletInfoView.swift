//
//  WalletInfoView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/2.
//

import SwiftUI

struct WalletInfoView: View {
	@State var showAddress: Bool = false
	var address: String?
	var name: String?
	
    var body: some View {
			HStack(spacing: 12) {
				Image("mouseAvatar")
					.resizable()
					.size(44)
					.cornerRadius(22)
				VStack(alignment: .leading, spacing: 0) {
					HStack {
						if (showAddress) {
							// TODO: Copy
							Text(address)
								.foregroundColor(.black)
								.AvenirNextRegular(size: 14)
								.cornerRadius(10)
								.truncationMode(.middle)
								.lineLimit(0)
						} else {
							Text(name)
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
    }
}

struct WalletInfoView_Previews: PreviewProvider {
    static var previews: some View {
			WalletInfoView(address: "0xdAC17F958D2ee523a2206206994597C13D831ec7", name: "Wallet 1")
    }
}
