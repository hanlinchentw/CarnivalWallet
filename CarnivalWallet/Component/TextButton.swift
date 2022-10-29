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

	var body: some View {
		Button(action: onPress) {
			Text(text)
				.AvenirNextMedium(size: 14)
				.foregroundColor(.black)
		}
		.buttonStyle(.plain)
	}
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
			TextButton(text: "", onPress: {
				
			})
    }
}
