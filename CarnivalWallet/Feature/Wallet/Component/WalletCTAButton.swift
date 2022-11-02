//
//  WalletCTAButton.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/2.
//

import SwiftUI

enum WalletCTAType: String {
	case Receive = "Receive"
	case Send = "Send"
	
	var icon: String {
		switch self {
		case .Receive: return "arrow.down.to.line"
		case .Send: return "arrow.up.right"
		}
	}
}

struct WalletCTAButton: View {
	var type: WalletCTAType
	var body: some View {
		Button {
			//TODO: receive page
		} label: {
			HStack {
				Image(systemName: type.icon)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(height: 18)
				Text(type.rawValue)
					.AvenirNextMedium(size: 14)
			}
			.foregroundColor(.white)
		}
		.padding(.vertical, 16)
		.width(150)
		.background(.blue)
		.cornerRadius(28)
	}
}

struct WalletCTAButton_Previews: PreviewProvider {
	static var previews: some View {
		WalletCTAButton(type: .Receive)
	}
}
