//
//  AccountInfoView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/5.
//

import SwiftUI

struct AccountInfoView: View {
	var name: String?
	var balance: String?
	var address: String?

	var body: some View {
		VStack(alignment: .leading) {
			Image("mouse_avatar")
				.resizable()
				.size(56)
				.cornerRadius(28)
			Text(name)
				.AvenirNextMedium(size: 20)
			if let balance {
				Text("$\(balance)")
					.AvenirNextRegular(size: 14)
			}
			
			Text(address)
				.AvenirNextRegular(size: 14)
				.foregroundColor(.black.opacity(0.7))
				.lineLimit(0)
				.truncationMode(.middle)
				.frame(maxWidth: 90)
				.tapToClip(string: address)
		}
	}
}

struct AccountInfoView_Previews: PreviewProvider {
	static var previews: some View {
		AccountInfoView()
	}
}
