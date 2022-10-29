//
//  TextButton.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/29.
//

import SwiftUI

enum TextButtonStyle {
	case rectengle
	case capsule
}

struct TextButton: View {
	var text: String
	var width: CGFloat = 0
	var height: CGFloat = 0
	var disabled: Bool = false
	var style: TextButtonStyle
	var onPress: () -> Void

	var body: some View {
		Button(action: onPress) {
			Text(text)
				.AvenirNextMedium(size: 14)
				.foregroundColor(.white)
		}
		.width(width)
		.height(height)
		.background(.black)
		.if(style == .rectengle, modify: { $0.cornerRadius(8) })
		.if(style == .capsule, modify: { $0.clipShape(Capsule()) })
		.buttonStyle(.plain)
		.disabled(disabled)
	}
}

struct TextButton_Previews: PreviewProvider {
	static var previews: some View {
		TextButton(text: "Import", width: DeviceDimension.WIDTH - 80, height: 56, style: .rectengle, onPress: {
			
		})
	}
}
