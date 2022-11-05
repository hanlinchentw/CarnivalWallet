//
//  String+Extensions.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import Foundation

extension String {
	var toURL: URL {
		URL(string: self)!
	}
}
