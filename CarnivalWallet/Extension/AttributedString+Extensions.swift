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

	static let system12: Attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
	static let system14: Attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
	static let system14Bold: Attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)]
	static let system16Bold: Attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)]

	static let courierNewPS24Bold: Attributes = [NSAttributedString.Key.font: UIFont(name: "CourierNewPS-BoldMT", size: 24)]

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
