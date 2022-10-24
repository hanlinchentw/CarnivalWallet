//
//  TextFont.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import SwiftUI

extension Text {
	func regular(size: CGFloat) -> Self {
		return self.font(.custom("AvenirNext-Regular", fixedSize: size))
	}
	
	func regular12() -> Self {
		return self.regular(size: 12)
	}
	
	func regular14() -> Self {
		return self.regular(size: 14)
	}
	
	func regular16() -> Self {
		return self.regular(size: 16)
	}

	func medium(size: CGFloat) -> Self {
		return self.font(.custom("AvenirNext-Medium", fixedSize: size))
	}
	
	func medium12() -> Self {
		return self.medium(size: 12)
	}
	
	func medium14() -> Self {
		return self.medium(size: 14)
	}
	
	func medium16() -> Self {
		return self.medium(size: 16)
	}
	
	func bold(size: CGFloat) -> Self {
		return self.font(.custom("AvenirNext-Bold", fixedSize: size))
	}
	
	func bold12() -> Self {
		return self.bold(size: 12)
	}
	
	func bold14() -> Self {
		return self.bold(size: 14)
	}
	
	func bold16() -> Self {
		return self.bold(size: 16)
	}
}
