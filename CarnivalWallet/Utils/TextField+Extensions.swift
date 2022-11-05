//
//  TextField+Extendsions.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import SwiftUI

extension TextField {
	func placeholder<Content: View>(
		when shouldShow: Bool,
		alignment: Alignment = .leading,
		@ViewBuilder placeholder: () -> Content) -> some View {

			ZStack(alignment: alignment) {
				placeholder().opacity(shouldShow ? 1 : 0)
				self
			}
		}
}
