//
//  CastError.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/6.
//

import Foundation

struct CastError<ExpectedType>: Error {
	let actualValue: Any
	let expectedType: ExpectedType.Type
}
