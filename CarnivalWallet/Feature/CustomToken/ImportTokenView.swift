//
//  AddTokenView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/15.
//

import SwiftUI

struct ImportTokenView: View {
	@Environment(\.presentationMode) var presentationMode
	@StateObject var vm: ImportTokenViewModel = .init()
	
	var dismiss: VoidClosure {
		{
			presentationMode.wrappedValue.dismiss()
		}
	}
	
	var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()
			VStack {
				VStack {
					TokenAddressTextField(
						title: "Token Address",
						placeholder: "0x...",
						text: $vm.contractAddress,
						onPaste: vm.onPaste,
						onClickScanButton: vm.onClickScanButton,
						onSubmit: vm.onSearch
					)
					if let errorMessage = vm.errorMessage {
						HStack {
							Image(systemName: "exclamationmark.triangle.fill")
								.resizable()
								.size(12)
							Text(errorMessage)
								.AvenirNextMedium(size: 14)
							Spacer()
						}
						.foregroundColor(.redNormal)
					}
				}
				VStack {
					if vm.isLoading {
						ProgressView {
							Text("Loading ...")
						}
					} else if let tokenInfo = vm.tokenInfo {
						HStack {
							Text("Profile")
								.AvenirNextMedium(size: 20)
							Spacer()
						}
						VStack {
							VStack(spacing: 16) {
								CoinIconView(
									network: Network.ethereum.rawValue,
									contractAddress: tokenInfo.contractAddress,
									size: 56
								)
								TokenInfoRow(title: "Name", value: tokenInfo.name)
								TokenInfoRow(title: "Symbol", value: tokenInfo.symbol)
								TokenInfoRow(title: "Decimals", value: tokenInfo.decimals)
								Link(destination: Etherscan.route.token(tokenInfo.contractAddress).url) {
									HStack {
										Text("View on etherscan")
											.AvenirNextRegular(size: 16)
										Image(systemName: "link")
											.resizable()
											.size(12)
									}
									.foregroundColor(.blue)
								}
							}
							.padding(16)
						}
						.background(Color.gray.opacity(0.1))
						.cornerRadius(16)

						HStack {
							BaseButton(
								text: "Cancel",
								textSize: 16,
								fillColor: .black,
								height: 50,
								style: .capsule,
								onPress: dismiss
							)
							BaseButton(
								text: "Import",
								textSize: 16,
								fillColor: .blue,
								height: 50,
								style: .outline,
								onPress: {
									vm.onImport()
									dismiss()
								}
							)
						}
						.padding(.top, 16)
					}
					Link(destination: Etherscan.route.tokens.url) {
						Text("View all ERC-20 Tokens")
							.AvenirNextMedium(size: 16)
					}

				}
				.padding(.top, 32)
				
				Spacer()
			}
			.padding(.top, 32)
			.padding(.horizontal, 16)
		}
		.tapToResign()
		.toolbar(.hidden)
		.header(
			title: "Import Tokens",
			leftItem: {
				Image(systemName: "chevron.left")
			},
			onPressedLeftItem: dismiss
		)
		.sheet(isPresented: $vm.presentScanQRCodeView, content: {
			ScannerView(
				onScan: vm.onScan,
				onClose: vm.onCloseQRScanner
			).ignoresSafeArea()
		})
		.onReceive(vm.dismiss) { _ in
			self.dismiss()
		}
	}
}

struct AddTokenView_Previews: PreviewProvider {
	static var previews: some View {
		ImportTokenView()
	}
}
