//
//  BalanceProvider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/6.
//

import Foundation
import APIKit

protocol BalanceProvider {
	associatedtype Request: JsonRpcRequest
	var address: String { get set }
	func getBalance() async throws -> String
}

protocol TokenBalanceProvider: BalanceProvider {
	var contractAddress: String { get set }
}
