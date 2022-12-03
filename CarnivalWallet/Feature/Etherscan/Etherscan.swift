//
//  Etherscan.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/3.
//

import Foundation

struct Etherscan {
	
	enum route {
		case tokens(String)
		case address(String)
		case transaction(String)
		
		var url: URL {
			switch self {
			case .tokens(let contractAddress):
				return "https://etherscan.io/token/\(contractAddress)".toURL
			case .address(let address):
				return "https://etherscan.io/address/\(address)".toURL
			case .transaction(let txHash):
				return "https://etherscan.io/tx/\(txHash)".toURL
			}
		}
		
	}
}
