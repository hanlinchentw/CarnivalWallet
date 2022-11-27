//
//  SendView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/21.
//

import SwiftUI

struct SendView: View {
	var coin: Coin
	@Environment(\.presentationMode) var presentationMode
	@Binding var path: NavigationPath
	@StateObject var vm = SendViewModel()
	
	var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()
			VStack {
				ScrollView {
					VStack(alignment: .center) {
						VStack {
							CoinIconView(
								network: Network.ethereum.rawValue,
								contractAddress: coin.contractAddress,
								size: 44
							)
							
							Text(coin.name)
								.AvenirNextMedium(size: 16)
						}
						.padding(.top, 32)
						
						VStack(alignment: .leading) {
							HStack {
								Text("From")
									.AvenirNextRegular(size: 16)
								Spacer()
								Text("Balance: ", coin.balance, " ", coin.symbol)
									.AvenirNextRegular(size: 14)
							}
							
							HStack {
								Image(name: "mouse_avatar")
									.resizable()
									.size(40)
									.cornerRadius(20)
								VStack(alignment: .leading) {
									HStack {
										Text(vm.account.name)
											.AvenirNextMedium(size: 16)
										Text(vm.account.address)
											.AvenirNextRegular(size: 14)
											.lineLimit(1)
											.truncationMode(.middle)
									}
								}
								.padding(.horizontal, 8)
								Spacer()
								Image(systemName: "chevron.down")
							}
							.height(56)
							.padding(.trailing, 8)
						}
						.padding(.top, 16)
						
						VStack(alignment: .leading) {
							TokenAddressTextField(
								title: "To",
								placeholder: "Public address 0x...",
								text: $vm.sendToAddress,
								hideReturnButton: true,
								onPaste: vm.onPaste,
								onClickScanButton: vm.onClickScanButton
							)
						}
						.padding(.top, 16)
					}
				}
				Spacer()
				BaseButton(text: "Next", height: 56, disabled: vm.sendToAddress.isEmpty, style: .capsule) {
					vm.onPressNextButton {
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
			.sheet(isPresented: $vm.qrScannerVisible, content: {
				ScannerView(
					onScan: vm.onScan,
					onClose: vm.onCloseScanner
				).ignoresSafeArea()
			})
		}
	}
}

struct SendView_Previews: PreviewProvider {
	static var previews: some View {
		SendView(coin: .testETH, path: .constant(.init()))
	}
}
