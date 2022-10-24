//
//  ImportPhraseView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import SwiftUI

struct ImportPhraseView: View {
	@Environment(\.presentationMode) var presentationMode

	@State var phraseText: String = ""
	@State var isFaceIdOn: Bool = true

	init() {
		UINavigationBar.appearance().titleTextAttributes = .courierNewPS24Bold
	}
	
	var body: some View {
		ZStack {
			ScrollView() {
				VStack(alignment: .leading) {
					Text("Secret Recovery Phrase")
						.medium16()
						.padding(.top, 24)
					TextField("Enter your Secret Recovery Phrase", text: $phraseText)
					.padding(.init(top: 12, leading: 12, bottom: 88, trailing: 12))
					.roundedBorder(radius: 8, borderColor: .black, borderWidth: 1)
					
					Text("Password")
						.medium16()
						.padding(.top, 24)
					TextField("New Password", text: $phraseText)
					.padding(.init(top: 12, leading: 12, bottom: 12, trailing: 12))
					.roundedBorder(radius: 8, borderColor: .black, borderWidth: 1)
					
					Text("Confirm password")
						.medium16()
						.padding(.top, 24)
					TextField("Confirm password", text: $phraseText)
					.padding(.init(top: 12, leading: 12, bottom: 12, trailing: 12))
					.roundedBorder(radius: 8, borderColor: .black, borderWidth: 1)
					Text("Must be at least 8 characters")
						.medium14()
					
					HStack {
						Text("Unlock with FaceID?")
							.medium16()
						Spacer()
						
						Toggle("", isOn: $isFaceIdOn)
					}
					Button {

					} label: {
						Text("Import")
							.medium14()
							.foregroundColor(.white)
							.padding()
							.width(DeviceDimension.WIDTH - 80)
							.background(.black)
							.clipShape(Capsule())
					}
					.buttonStyle(.plain)
					.padding(.top, 40)

				}
				.padding(.horizontal, 32)
	
			}
		}
		.navigationBarBackButtonHidden()
		.navigationTitle("Import from seed")
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button {
					presentationMode.wrappedValue.dismiss()
				} label: {
					Image(systemName: "chevron.left")
						.foregroundColor(.black)
				}
				
			}
		}
	}
}

struct ImportPhraseView_Previews: PreviewProvider {
	static var previews: some View {
		ImportPhraseView()
	}
}
