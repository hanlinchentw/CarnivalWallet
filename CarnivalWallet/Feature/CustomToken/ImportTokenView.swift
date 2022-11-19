//
//  AddTokenView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/15.
//

import SwiftUI

class ImportTokenViewModel: ObservableObject {
	weak var coordinator: WalletCoordinator?
	
	@Published var contractTextInput: String = ""
	@Published var symbolTextInput: String = ""
	@Published var decimalsTextInput: String = ""
	@Published var presentScanQRCodeView = false
	
	var dismiss: () -> Void {
		{
			self.coordinator?.didFinishAddToken()
		}
	}
	
	var onPaste: (_ text: String) -> Void {
		{ text in
			self.contractTextInput = text
		}
	}
	
	var onClickScanButton: () -> Void {
		{
			self.presentScanQRCodeView = true
		}
	}
	
	var onScan: (_ result: String) -> Void {
		{ result in
			self.contractTextInput = result
			self.presentScanQRCodeView = false
			self.getTokenInfo()
		}
	}
	
	var onCloseQRScanner: () -> Void {
		{
			self.presentScanQRCodeView = false
		}
	}
	
	func getTokenInfo() {
		Task {
			let provider = TokenInfoProvider(contractAddress: contractTextInput)
			let tokenInfo = try ObjectUtils.checkNotNil(try? await provider.getTokenInfo(), message: "")
			
			DispatchQueue.main.async {
				self.symbolTextInput = tokenInfo.symbol
				self.decimalsTextInput = tokenInfo.decimals
			}
		}
	}
}

struct ImportTokenView: View {
	@EnvironmentObject var coordinator: WalletCoordinator
	@StateObject var vm: ImportTokenViewModel = .init()
	
	var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()
			VStack(spacing: 56) {
				TokenInfoTextField(
					title: "Token Address",
					placeholder: "0x...",
					text: $vm.contractTextInput,
					onPaste: vm.onPaste,
					onClickScanButton: vm.onClickScanButton
				)
				TokenInfoTextField(
					title: "Token Symbol",
					placeholder: "USDT",
					text: $vm.symbolTextInput
				)
				TokenInfoTextField(
					title: "Token Decimal",
					placeholder: "6",
					text: $vm.decimalsTextInput
				)
				
				HStack {
					BaseButton(
						text: "Cancel",
						textSize: 16,
						fillColor: .black,
						height: 50,
						style: .outline,
						onPress: vm.dismiss
					)
					.padding(.horizontal, 16)
					BaseButton(
						text: "Import",
						textSize: 16,
						fillColor: .blue,
						height: 50,
						disabled: vm.contractTextInput.isEmpty,
						style: .outline,
						onPress: vm.dismiss
					)
					.padding(.horizontal, 16)
				}
				Spacer()
			}
			.padding(.top, 32)
			.padding(.horizontal, 16)
		}
		.tapToResign()
		.header(
			title: "Import Tokens",
			icon: {
				Image(systemName: "chevron.left")
			},
			onPressedItem: {
				coordinator.didFinishAddToken()
			}
		)
		.qrScannerSheet(
			isVisible: $vm.presentScanQRCodeView,
			onScan: vm.onScan,
			onClose: vm.onCloseQRScanner)
		.onAppear {
			self.vm.coordinator = coordinator
		}
	}
}

struct AddTokenView_Previews: PreviewProvider {
	static var previews: some View {
		ImportTokenView()
	}
}
