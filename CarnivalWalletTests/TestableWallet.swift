//
//  TestableWallet.swift
//  CarnivalWalletTests
//
//  Created by 陳翰霖 on 2022/11/6.
//

import Foundation
import WalletCore

class TestableWallet {
	static var testMnemonic: String {
		"ripple scissors kick mammal hire column oak again sun offer wealth tomorrow wagon turn fatal"
	}
	
	static var testWallet: HDWallet {
		HDWallet(mnemonic: testMnemonic, passphrase: "")!
	}
}
