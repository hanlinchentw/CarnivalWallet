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
	}
}
