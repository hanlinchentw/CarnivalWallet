//
//  SendView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/21.
//

import SwiftUI

struct SendView: View {
	@ObservedObject var coin: Coin
	@Environment(\.presentationMode) var presentationMode
	@Binding var path: NavigationPath
	@StateObject var vm = SendViewModel()
	
	var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()
			VStack {
				VStack(alignment: .center) {
					CoinInfoView(
						contractAddress: coin.contractAddress,
						name: coin.name
					)
					.padding(.top, 32)
					
					FromAddressView(
						accountName: vm.account.name,
						accountAddress: vm.account.address,
						balance: coin.balance,
						symbol: coin.symbol
					)
					.padding(.top, 16)
					
					TokenAddressTextField(
						title: "To",
						placeholder: "Public address 0x...",
						text: $vm.sendToAddress,
						hideReturnButton: true,
						onPaste: vm.onPaste,
						onClickScanButton: vm.onClickScanButton
					)
					.padding(.top, 16)
					if vm.toAddressInvalid != nil  {
						ErrorText("Invalid address")
					}
				}
				Spacer()
				BaseButton(
					text: "Next",
					height: 56,
					disabled: vm.nextButtonDisabled,
					style: .capsule
				) {
					vm.checkIfAddressValid {
						path.append(
							SendAmountViewObject(coin: coin, sendToAddress: vm.sendToAddress)
						)
					}
				}
			}
			.padding(.top, 16)
			.padding(.horizontal, 20)
			.toolbar(.hidden)
			.header(title: "Send to") {
				Image(systemName: "chevron.left")
			} onPressedLeftItem: {
				presentationMode.wrappedValue.dismiss()
			}
			.sheet(isPresented: $vm.qrScannerVisible) {
				ScannerView(
					onScan: vm.onScan,
					onClose: vm.onCloseScanner
				).ignoresSafeArea()
			}
		}
	}
}

struct SendView_Previews: PreviewProvider {
	static var previews: some View {
		SendView(coin: .testETH, path: .constant(.init()))
	}
}
