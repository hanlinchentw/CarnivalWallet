//
//  TextButton.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/29.
//

import SwiftUI

struct TextButton: View {
	var text: String
	var onPress: () -> Void

	init(_ text: String, onPress: @escaping () -> Void) {
		self.text = text
		self.onPress = onPress
	}
	
	var body: some View {
		Button(action: onPress) {
			Text(text)
				.AvenirNextMedium(size: 14)
//				.foregroundColor(.black)
		}
		.buttonStyle(.plain)
	}
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
			TextButton("", onPress: {
				
			})
    }
}
