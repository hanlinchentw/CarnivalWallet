//
//  IconButton.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/2.
//

import SwiftUI

struct IconButton: View {
	var icon: String
	var onPress: () -> Void

	init(_ icon: String, onPress: @escaping () -> Void) {
		self.icon = icon
		self.onPress = onPress
	}
    var body: some View {
			Button {
				onPress()
			} label: {
				Image(systemName: icon)
					.resizable()
					.scaledToFit()
			}
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
			IconButton("arrow.left.arrow.right") {
				
			}
    }
}
