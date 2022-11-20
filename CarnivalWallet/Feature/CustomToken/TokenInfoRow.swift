//
//  TokenInfoRow.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/20.
//

import SwiftUI

struct TokenInfoRow: View {
	var title: String
	var value: String

	var body: some View {
		ZStack {
			Text(value)
				.AvenirNextMedium(size: 16)
			HStack {
				Text(title)
					.AvenirNextRegular(size: 14)
				Spacer()
			}
		}
	}
}

struct TokenInfoRow_Previews: PreviewProvider {
	static var previews: some View {
		TokenInfoRow(title: "", value: "")
	}
}
