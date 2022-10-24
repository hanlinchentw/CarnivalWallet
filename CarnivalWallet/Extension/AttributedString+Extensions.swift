//
//  AttributedString+Extensions.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import UIKit

typealias Attributes = [NSAttributedString.Key : Any]

extension Attributes {
	static let black: Attributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
	static let lightGray: Attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]

	static let regular12: Attributes = [NSAttributedString.Key.font: UIFont.AvenirNextRegular(size: 12)]
	static let regular14: Attributes = [NSAttributedString.Key.font: UIFont.AvenirNextRegular(size: 14)]
	static let bold14: Attributes = [NSAttributedString.Key.font: UIFont.AvenirNextBold(size: 14)]
	static let bold16: Attributes = [NSAttributedString.Key.font: UIFont.AvenirNextBold(size: 16)]
	static let bold24: Attributes = [NSAttributedString.Key.font: UIFont.AvenirNextBold(size: 24)]

	static func attributes(_ attributes: Array<Attributes>) -> Attributes {
		var result = Attributes()
		for attribute in attributes {
			attribute.keys.forEach { key in
				let value = attribute[key]
				result[key] = value
			}
		}
		return result
	}
}
