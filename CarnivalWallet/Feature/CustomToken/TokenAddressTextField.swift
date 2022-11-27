//
//  TokenInfoTextField.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/15.
//

import SwiftUI

struct TokenAddressTextField: View {
	var title: String
	var placeholder: String
	@Binding var text: String
	
	var hideReturnButton: Bool = false

	var onPaste: (_ text: String) -> Void
	var onClickScanButton: VoidClosure
	var onSubmit: VoidClosure = {}
	
	var body: some View {
		VStack(spacing: 0) {
			HStack(spacing:  16) {
				Text(title)
					.AvenirNextRegular(size: 16)
				Spacer()
				if let onClickScanButton {
					Image("scan_code")
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
			
			
			RoundedRectangle(cornerRadius: 8)
				.strokeBorder(style: .init())
				.overlay {
					HStack {
						TextField(placeholder, text: $text, onCommit: onSubmit)
							.AvenirNextRegular(size: 14)
							.padding(.vertical, 10)
						if !text.isEmpty, !hideReturnButton {
							Divider()
								.padding(8)
							Button {
								onSubmit()
							} label: {
								Image(systemName: "arrow.right")
									.resizable()
									.foregroundColor(.black)
							}
							.size(16)
						}
						
					}
					.padding(.horizontal, 16)
				}
				.height(56)
		}
	}
}

struct TokenInfoTextField_Previews: PreviewProvider {
	static var previews: some View {
		TokenAddressTextField(title: "Token Address", placeholder: "0x", text: .constant("fuhewiofnmsdkfoewifhoidskmcapslrf[ewopjfioiedsmfj0pioepfkadsoifjwepfoew")) { text in
			
		} onClickScanButton: {
			
			
		} onSubmit: {
			
			
		}
		
	}
}
