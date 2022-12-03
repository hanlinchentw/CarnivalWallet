//
//  Etherscan.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/3.
//

import Foundation

struct Etherscan {
	
	enum route {
		
		case token(String)
		case tokens
		case address(String)
		case transaction(String)
		
		var url: URL {
			switch self {
			case .token(let contractAddress):
				return "https://etherscan.io/token/\(contractAddress)".toURL
			case .tokens:
				return "https://etherscan.io/tokens".toURL
			case .address(let address):
				return "https://etherscan.io/address/\(address)".toURL
			case .transaction(let txHash):
				return "https://etherscan.io/tx/\(txHash)".toURL
			}
		}
		
	}
}
