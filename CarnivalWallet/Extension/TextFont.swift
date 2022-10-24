//
//  TextFont.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import SwiftUI

extension Text {
	func AvenirNextRegular(size: CGFloat) -> Self {
		return self.font(.custom("AvenirNext-Regular", fixedSize: size))
	}

	func AvenirNextMedium(size: CGFloat) -> Self {
		return self.font(.custom("AvenirNext-Medium", fixedSize: size))
	}

	func AvenirNextBold(size: CGFloat) -> Self {
		return self.font(.custom("AvenirNext-Bold", fixedSize: size))
	}
}
