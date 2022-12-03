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
		
		private var baseURL: String {
			"https://etherscan.io"
		}
		
		var url: URL {
			switch self {
			case .token(let contractAddress):
				return "\(baseURL)/token/\(contractAddress)".toURL
			case .tokens:
				return "\(baseURL)/tokens".toURL
			case .address(let address):
				return "\(baseURL)/address/\(address)".toURL
			case .transaction(let txHash):
				return "\(baseURL)/tx/\(txHash)".toURL
			}
		}
		
	}
}
