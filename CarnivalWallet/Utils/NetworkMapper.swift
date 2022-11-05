//
//  NetworkMapper.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/1.
//

import Foundation
import WalletCore

enum Network: String {
	case ethereum = "Ethereum"
}

final class NetworkMapper {
	func mapNetworkToCoinType(network: Network) -> CoinType? {
		switch network {
		case .ethereum:
			return CoinType.ethereum
		}
	}
}
