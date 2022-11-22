//
//  TextButton.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/29.
//

import SwiftUI

struct TextButton: View {
	var text: String
	var color: Color
	var onPress: () -> Void

	init(_ text: String, color: Color = .black, onPress: @escaping () -> Void) {
		self.text = text
		self.onPress = onPress
		self.color = color
	}
	
	var body: some View {
		Button(action: onPress) {
			Text(text)
				.AvenirNextMedium(size: 14)
				.foregroundColor(color)
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
