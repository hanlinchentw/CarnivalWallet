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

enum IconPosition {
	case right
	case left
}
struct BaseButton: View {
	var text: String
	var icon: String? = nil
	var iconSize: CGFloat = 14
	var iconPosition: IconPosition = .left
	var textSize: CGFloat = 14
	var fillColor: Color = .black
	var width: CGFloat?
	var height: CGFloat = 0
	var borderWidth: CGFloat = 1
	var disabled: Bool = false
	var style: TextButtonStyle
	var onPress: () -> Void

	var body: some View {
		Button(action: onPress) {
			HStack(spacing: 16) {
				if let icon, iconPosition == .left {
					Image(systemName: icon)
						.size(iconSize)
				}
				Text(text)
					.AvenirNextMedium(size: textSize)
				if let icon, iconPosition == .right {
					Image(systemName: icon)
						.size(iconSize)
				}
			}
			.foregroundColor(style == .outline ? fillColor: .white)
		}
		.frame(maxWidth: .infinity)
		.if(width != nil, modify: { $0.width(width!) })
		.height(height)
		.if(style == .rectengle, modify: { $0.background(fillColor).cornerRadius(8) })
		.if(style == .capsule, modify: { $0.background(fillColor).clipShape(Capsule()) })
		.if(style == .outline) {
			$0.background(.clear)
				.roundedBorder(radius: height/2, borderColor: fillColor, borderWidth: borderWidth)
		}
		.buttonStyle(.plain)
		.disabled(disabled)
	}
}

struct BaseButton_Previews: PreviewProvider {
	static var previews: some View {
		BaseButton(text: "Import", icon: "pencil.circle", width: DeviceDimension.WIDTH - 80, height: 56,disabled: true, style: .capsule, onPress: {
			
		})
		.foregroundColor(.blue)
	}
}
