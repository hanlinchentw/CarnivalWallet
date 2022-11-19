//
//  CoinIconView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/1.
//

import SwiftUI
import WalletCore

struct CoinIconView: View {
	var network: String?
	var contractAddress: String?
	var size: CGFloat
	
	func getIconURL(contractAddress: String) -> URL {
		let address = AnyAddress(string: contractAddress, coin: .ethereum)!.description
		let url = "https://assets-cdn.trustwallet.com/blockchains/\(network)/assets/\(address)/logo.png".toURL
		return url
	}

	var body: some View {
		if let contractAddress {
			AsyncImage(url: getIconURL(contractAddress: contractAddress)) { image in
				image
					.resizable()
					.scaledToFit()
			} placeholder: {
				Color.gray.opacity(0)
			}
			.size(size)
		} else if let network {
			Image(network.lowercased())
				.resizable()
				.scaledToFit()
				.size(size)
		}
	}
}

struct CoinIconView_Previews: PreviewProvider {
	static var previews: some View {
		CoinIconView(network: Network.ethereum.rawValue, size: 44)
	}
}
