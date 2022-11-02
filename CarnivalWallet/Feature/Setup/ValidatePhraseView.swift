//
//  ValidatePhraseView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/29.
//

import SwiftUI

struct ValidatePhraseView: View {
	@EnvironmentObject var coordinator: SetupCoordinator
	@Environment(\.presentationMode) var presentationMode
	
	let filledPhraseItems: [GridItem] = .init(repeating: .init(.flexible(), spacing: 32), count: 6)
	let bottomPhraseItems: [GridItem] = .init(repeating: .init(), count: 3)
	
	@StateObject var vm = ValidatePhraseViewModel()
	
	var wordList: Array<String>
	var randomWordList: Array<String>
	
	init(wordList: Array<String>) {
		self.wordList = wordList
		self.randomWordList = wordList.shuffled()
	}
	
	var body: some View {
		ZStack {
			Color.white
				.ignoresSafeArea()

			VStack {
				Group {
					Text("Confirm Secret Recovery Phrase")
						.AvenirNextMedium(size: 20)
					
					Text("Select each word in the order it was presented to you.")
						.AvenirNextRegular(size: 16)
						.padding(.top, 4)
				}
				.multilineTextAlignment(.center)
				
				phraseSheet
				
				unfilledPhraseList
				
				BaseButton(
					text: "Continue",
					width: DeviceDimension.WIDTH - 80,
					height: 56,
					disabled: vm.isContinueBtnDisabled,
					style: .capsule
				) {
					coordinator.finishSetup()
				}
				.padding(.top, 24)
			}
			.padding(.horizontal, 32)
		}
		.onAppear {
			self.vm.trueAnswer = wordList
		}
	}
	
	var phraseSheet: some View {
		LazyHGrid(rows: filledPhraseItems) {
			ForEach(0 ..< 12, id: \.self) { index in
				HStack {
					Text("\(index+1).")
					Button {
						vm.unfillAnswer(index)
					} label: {
						Text("\(vm.wordMap[index] ?? "")")
							.AvenirNextRegular(size: 14)
							.width(100)
					}
					.buttonStyle(.plain)
					.height(24)
					.capsuleWithDashBorder(borderColor: vm.targetIndex == index ? .blue : .black, borderWidth: 1)
					.padding(.trailing, 12)
				}
			}
		}
		.padding(.vertical, 20)
		.padding(.horizontal, 32)
		.roundedBorder(
			radius: 8,
			borderColor: vm.isAnswerWrong ? .red : .gray,
			borderWidth: 1
		)
	}
	
	var unfilledPhraseList: some View {
		LazyVGrid(columns: bottomPhraseItems) {
			ForEach(0 ..< randomWordList.indices.count, id: \.self) { index in
				let word = randomWordList[index]
				Button {
					vm.fillAnswer(word)
				} label: {
					Text("\(word)")
						.AvenirNextRegular(size: 14)
						.width(100)
				}
				.buttonStyle(.plain)
				.disabled(vm.isFilled(word))
				.padding(.vertical, 4)
				.capsuleBorder(borderColor: .blue, borderWidth: 1)
				.padding(.vertical, 4)
			}
		}
		.padding(.top, 16)
	}
}

struct ValidatePhraseView_Previews: PreviewProvider {
	static var previews: some View {
		let testMneomonic = "ripple scissors kick mammal hire column oak again sun offer wealth tomorrow"
		ValidatePhraseView(wordList: testMneomonic.components(separatedBy: " "))
	}
}
