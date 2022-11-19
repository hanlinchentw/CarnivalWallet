//
//  TokenInfoTextField.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/15.
//

import SwiftUI

struct TokenInfoTextField: View {
	var title: String
	var placeholder: String
	@Binding var text: String
	
	var onPaste: ((_ text: String) -> Void)? = nil
	var onClickScanButton: VoidClosure? = nil
	
	var body: some View {
		VStack(spacing: 0) {
			HStack(spacing:  16) {
				Text(title)
					.AvenirNextRegular(size: 16)
				Spacer()
				if let onClickScanButton {
					Image(systemName: "text.viewfinder")
						.onTapGesture(perform: onClickScanButton)
					Divider().height(14)
				}
				if let onPaste {
					Image(systemName: "doc.on.clipboard")
						.onTapGesture {
							onPaste(UIPasteboard.general.string ?? "")
						}
				}
			}
			.padding(.bottom, 10)
			TextField(placeholder, text: $text)
				.AvenirNextRegular(size: 14)
				.padding(.vertical, 12)
				.padding(.horizontal, 16)
				.roundedBorder(radius: 4, borderColor: .gray, borderWidth: 1)
		}
	}
}

struct TokenInfoTextField_Previews: PreviewProvider {
	static var previews: some View {
		TokenInfoTextField(title: "Token Address", placeholder: "0x", text: .constant(""))
	}
}
