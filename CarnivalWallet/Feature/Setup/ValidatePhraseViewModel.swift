//
//  ValidatePhraseViewModel.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/29.
//

import SwiftUI
import Combine

final class ValidatePhraseViewModel: ObservableObject {
	@Published var wordMap: Dictionary<Int, String> = [:]
	@Published var trueAnswer: Array<String> = []
	@Published var isAnswerWrong: Bool = false

	var set = Set<AnyCancellable>()
	
	var targetIndex: Int {
		for i in 0 ..< 12 {
			if wordMap[i] == nil { return i }
		}
		return -1
	}
	
	var unfillAnswer: (_ index: Int) -> Void {
		{ index in
			self.wordMap.removeValue(forKey: index)
		}
	}
	
	var fillAnswer: (_ word: String) -> Void {
		{ word in
			self.wordMap[self.targetIndex] = word
		}
	}
	
	var isFilled: (_ word: String) -> Bool {
		{ word in
			self.wordMap.contains(where: { $0.value == word })
		}
	}
	
	var isContinueBtnDisabled: Bool {
		if wordMap.count != 12 { return  true }
		return isAnswerWrong
	}
	
	init() {
		$wordMap.sink { pair in
			print(self.trueAnswer)
			if pair.count == 12 {
				for (index, word) in self.trueAnswer.enumerated() {
					if pair[index] != word {
						self.isAnswerWrong = true
						return
					}
				}
			}
		}
		.store(in: &set)
	}
}
