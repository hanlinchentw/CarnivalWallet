//
//  PasswordInputView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/29.
//

import SwiftUI

enum PasswordStrength: String {
	case weak = "Weak"
	case medium = "Medium"
	case strong = "Strong"
	
	var textColor: Color {
		switch self {
		case .weak: return Color.redNormal
		case .medium: return Color.orangeNormal
		case .strong: return Color.greenNormal
		}
	}
}

struct PasswordInputView: View {
	@Binding var password: String
	@Binding var confirmPassword: String
	@State var isSecure: Bool = true
	@Binding var isBioAuthOn: Bool
	var passwordStrength: PasswordStrength?
	
	var body: some View {
		VStack {
			VStack(alignment: .leading) {
				HStack {
					Text("Password")
						.AvenirNextMedium(size: 16)
					Spacer()
					TextButton(
						text: isSecure ? "Show" : "Hide",
						onPress: {
						isSecure.toggle()
					})
				}
				
				SencitiveTextField(text: $password, isSecure: isSecure, placeholder: "New Password")
				
				HStack(spacing: 2) {
					Text("Password strength: ")
						.AvenirNextMedium(size: 14)
					if let passwordStrength {
						Text(passwordStrength.rawValue)
							.AvenirNextMedium(size: 12)
							.foregroundColor(passwordStrength.textColor)
					}
				}
				
				
				Text("Confirm password")
					.AvenirNextMedium(size: 16)
					.padding(.top, 4)
				SencitiveTextField(text: $confirmPassword, isSecure: isSecure, placeholder: "Confirm password")
				
				Text("Must be at least 8 characters").AvenirNextMedium(size: 14)
			}
			HStack {
				Text("Unlock with FaceID?")
					.AvenirNextMedium(size: 16)
				Spacer()
				Toggle("", isOn: $isBioAuthOn)
					.width(56)
			}
		}
	}
}

struct PasswordInputView_Previews: PreviewProvider {
	static var previews: some View {
		PasswordInputView(password: .constant(""), confirmPassword: .constant(""), isBioAuthOn: .constant(true), passwordStrength: .strong)
	}
}
