//
//  WalletFiatBalanceView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/2.
//

import SwiftUI

struct WalletFiatBalanceView: View {
	var balance: String
    var body: some View {
			HStack {
				VStack(alignment: .leading) {
					Text("total balance")
						.AvenirNextRegular(size: 16)
					Text("$\(balance)")
						.AvenirNextBold(size: 48)
				}
				Spacer()
			}
			.padding(.horizontal, 20)
			.padding(.vertical, 16)
    }
}

struct WalletFiatBalanceView_Previews: PreviewProvider {
    static var previews: some View {
			WalletFiatBalanceView(balance: "17.64")
    }
}
