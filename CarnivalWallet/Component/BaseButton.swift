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
	var icon: String? = nil
	var iconSize: CGFloat = 14
	var textSize: CGFloat = 14
	var fillColor: Color = .black
	var width: CGFloat?
	var height: CGFloat = 0
	var disabled: Bool = false
	var style: TextButtonStyle
	var onPress: () -> Void

	var body: some View {
		Button(action: onPress) {
			HStack(spacing: 16) {
				if let icon {
					Image(systemName: icon)
						.size(iconSize)
				}
				Text(text)
					.AvenirNextMedium(size: textSize)
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
				.roundedBorder(radius: height/2, borderColor: fillColor, borderWidth: 1)
		}
		.buttonStyle(.plain)
		.disabled(disabled)
	}
}

struct BaseButton_Previews: PreviewProvider {
	static var previews: some View {
		BaseButton(text: "Import", icon: "pencil.circle", width: DeviceDimension.WIDTH - 80, height: 56, style: .outline, onPress: {
			
		})
		.foregroundColor(.blue)
	}
}
