//
//  SecurePhraseView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/29.
//

import SwiftUI

struct SecurePhraseView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var vm: InitializeWalletViewModelImpl
	
	@State var viewPhrase: Bool = true

	let gridItems: [GridItem] = .init(repeating: .init(.flexible(), spacing: 32), count: 6)

	var body: some View {
		ZStack {
			VStack {
				Group {
					Text("Write down your Secret Recovery Phrase")
						.AvenirNextMedium(size: 20)
						
					Text("This is your Secret Recovery Phrase. Write it down on a paper and keep it in a safe place. You'll be asked to re-enter this phrase (in order) on the next step.")
						.AvenirNextRegular(size: 16)
						.padding(.top, 4)
				}
				.multilineTextAlignment(.center)
				.padding(.horizontal, 32)
				
				if (viewPhrase) {
					phraseView
				} else {
					secureView
				}

				NavigationLink {
					ValidatePhraseView(wordList: vm.wordList)
				} label: {
					Text("Continue")
						.AvenirNextMedium(size: 14)
						.foregroundColor(.white)
				}
				.frame(width: DeviceDimension.WIDTH - 80, height: 56)
				.background(.black)
				.clipShape(Capsule())
				.disabled(!viewPhrase)
				.padding(.top, 44)
			}
		}
		.navbarLeftItem { backButton }
		.onAppear {
			vm.createWallet()
		}
	}
	
	var backButton: some View {
		Button {
			vm.deleteWallet()
			presentationMode.wrappedValue.dismiss()
		} label: {
			Image(systemName: "chevron.left")
				.foregroundColor(.black)
		}
	}
	
	var phraseView: some View {
		VStack {
			LazyHGrid(rows: gridItems) {
				ForEach(0 ..< vm.wordList.indices.count, id: \.self) { index in
					Text("\(index+1). \(vm.wordList[index])")
						.AvenirNextRegular(size: 14)
						.width(120)
						.padding(.vertical, 4)
						.capsuleBorder(borderColor: .gray, borderWidth: 1)
						.padding(.horizontal, 12)
				}
			}
			.padding(.vertical, 12)
			.padding(.horizontal, 32)
		}
		.padding(.vertical, 4)
		.roundedBorder(radius: 8, borderColor: .gray, borderWidth: 1)
		.padding(.horizontal, 32)
	}
	
	var secureView: some View {
		VStack {
			Image(systemName: "eye.slash")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 32, height: 32)
				.foregroundColor(.white)
				.padding(.top, 32)
			
			Group {
				Text("Tap to reveal your Secret Recovery Phrase")
					.AvenirNextMedium(size: 16)
					.padding(.top, 20)
				Text("Make sure no one is watching your screen.")
					.AvenirNextRegular(size: 12)
					.padding(.top, 2)

			}
			.foregroundColor(.white)
			.multilineTextAlignment(.center)
			.fixedSize()
			.padding(.horizontal, 32)
			BaseButton(text: "View", textSize: 20, width: 160, height: 44, style: .outline) {
				viewPhrase = true
			}
			.padding(.top, 20)
			.padding(.bottom, 32)
		}
		.background(.black.opacity(0.9))
		.cornerRadius(8)
		.padding(.top, 16)
	}
}

struct SecurePhraseView_Previews: PreviewProvider {
	static var previews: some View {
		SecurePhraseView(vm: .init())
	}
}
