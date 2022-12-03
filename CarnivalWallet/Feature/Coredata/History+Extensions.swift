//
//  History+Extensions.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/1.
//

import Foundation
import CoreData

extension History {
	convenience init(txHash: String) {
		let entity = NSEntityDescription.entity(forEntityName: "History", in: .defaultContext)!
		self.init(entity: entity, insertInto: .defaultContext)
		self.txHash = txHash
		self.isConfirm = false
	}
}

extension History {
	static var testHistory: History {
		let test = History(txHash: "0x5988c7acf6a3274b444c7944091c117b7140ce0aa289c548807c0a979b4da4a1")
		test.from = "0x1e200594af3e23462a035076f3499295734a3c1d"
		test.to = "0x1e200594af3e23462a035076f3499295734a3c1d"
		test.amount = "0.00001"
		test.timestamp = 1669098009
		test.fee = "0.000210694783278"
		return test
	}
}


