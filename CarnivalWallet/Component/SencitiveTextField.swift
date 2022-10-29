//
//  SencitiveTextField.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/29.
//

import SwiftUI

struct SencitiveTextField: View {
	@Binding var text: String
	@State var isSecure: Bool = true
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
			
			Button(action: {
				isSecure.toggle()
			}, label: {
				Image(systemName: !isSecure ? "eye.slash" : "eye" ).frame(width: 28, height: 28)
			})
		}
		.padding(.init(top: 12, leading: 12, bottom: 12, trailing: 12))
		.roundedBorder(radius: 8, borderColor: .black, borderWidth: 1)
	}
}

struct SencitiveTextField_Previews: PreviewProvider {
	static var previews: some View {
		SencitiveTextField(text: .constant(""), placeholder: "")
	}
}
