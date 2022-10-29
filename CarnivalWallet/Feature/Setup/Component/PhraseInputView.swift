//
//  PhraseInputView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/29.
//

import SwiftUI

struct PhraseInputView: View {
	@Binding var phrase: String
	var phraseValid: Bool
	
	var body: some View {
		VStack(alignment: .leading) {
			Text("Secret Recovery Phrase")
				.AvenirNextMedium(size: 16)
				.padding(.top, 24)

			TextField("Enter your Secret Recovery Phrase", text: $phrase)
				.AvenirNextMedium(size: 16)
				.autocorrectionDisabled()
				.padding(.init(top: 12, leading: 12, bottom: 88, trailing: 12))
				.roundedBorder(
					radius: 8,
					borderColor: phraseValid ? .black : .red,
					borderWidth: 1
				)
			
			Text("Invalid Phrase. Phrase must be 12, 18, 24 words.")
				.AvenirNextRegular(size: 14)
				.lineLimit(2)
				.foregroundColor(.redNormal)
				.if(phraseValid, modify: { $0.hidden() })
		}
	}
}

struct PhraseInputView_Previews: PreviewProvider {
	static var previews: some View {
		PhraseInputView(phrase: .constant(""), phraseValid: false)
	}
}
