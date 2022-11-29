//
//  ReceiveView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/29.
//

import SwiftUI

struct ReceiveView: View {
	var coin: Coin
	
	var account: AccountEntity? {
		AccountManager.current ?? .testEthAccountEntity
	}
	
	var qrImage: UIImage? {
		let dataSet = QRCodeDataSet(string: "Hello world")
		return QRCodeGenerator(set: dataSet).create()
	}
	
	var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()
			VStack {
//				if let address = account?.address,
				if let qrImage {
					Image(uiImage: qrImage)
						.resizable()
						.size(300)
						.background(Color.yellow)
				}
				Spacer()
			}
			.toolbar(.hidden)
			.header(title: "Receive") {
				Image(systemName: "chevron.left")
			} onPressedLeftItem: {
				
			}
		}
	}
}

struct ReceiveView_Previews: PreviewProvider {
	static var previews: some View {
		ReceiveView(coin: .testETH)
	}
}
