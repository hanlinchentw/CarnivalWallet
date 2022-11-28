//
//  ErrorText.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/28.
//

import SwiftUI

struct ErrorText: View {
	var errorMessage: String
	var alignment: Alignment

	init(_ errorMessage: String, alignment: Alignment = .leading	) {
		self.errorMessage = errorMessage
		self.alignment = alignment
	}

	var body: some View {
		HStack {
			if alignment == .trailing {
				Spacer()
			}
			
			Image(systemName: "exclamationmark.triangle.fill")
				.resizable()
				.size(12)
			
			Text(errorMessage)
				.AvenirNextMedium(size: 14)
			
			if alignment == .leading {
				Spacer()
			}
		}
		.foregroundColor(.redNormal)
	}
}

struct ErrorText_Previews: PreviewProvider {
	static var previews: some View {
		ErrorText("")
	}
}

extension ErrorText {
	enum Alignment: Int {
		case leading
		case trailing
		case center
	}
}
