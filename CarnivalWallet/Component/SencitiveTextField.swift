//
//  SencitiveTextField.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/29.
//

import SwiftUI

struct SencitiveTextField: View {
	@Binding var text: String
	var isSecure: Bool
	var placeholder: String
	
	var body: some View {
		HStack{
			Group{
				if isSecure {
					SecureField(placeholder, text: $text)
						.AvenirNextMedium(size: 16)
				} else {
					TextField(placeholder, text: $text)
						.AvenirNextMedium(size: 16)
				}
			}
			
		}
		.padding(.init(top: 12, leading: 12, bottom: 12, trailing: 12))
		.height(44)
		.roundedBorder(radius: 8, borderColor: .black, borderWidth: 1)
	}
}

struct SencitiveTextField_Previews: PreviewProvider {
	static var previews: some View {
		SencitiveTextField(text: .constant(""), isSecure: true, placeholder: "")
	}
}
