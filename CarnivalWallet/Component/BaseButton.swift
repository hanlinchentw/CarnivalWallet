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
	case outline
}

struct BaseButton: View {
	var text: String
	var textSize: CGFloat = 14
	var width: CGFloat = 0
	var height: CGFloat = 0
	var disabled: Bool = false
	var style: TextButtonStyle
	var onPress: () -> Void

	var body: some View {
		Button(action: onPress) {
			Text(text)
				.AvenirNextMedium(size: textSize)
				.foregroundColor(.white)
		}
		.width(width)
		.height(height)
		.if(style == .rectengle, modify: { $0.background(.black).cornerRadius(8) })
		.if(style == .capsule, modify: { $0.background(.black).clipShape(Capsule()) })
		.if(style == .outline) { $0.background(.clear).roundedBorder(radius: height/2, borderColor: .white, borderWidth: 1) }
		.buttonStyle(.plain)
		.disabled(disabled)
	}
}

struct BaseButton_Previews: PreviewProvider {
	static var previews: some View {
		BaseButton(text: "Import", width: DeviceDimension.WIDTH - 80, height: 56, style: .rectengle, onPress: {
			
		})
	}
}
