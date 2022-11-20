//
//  AddTokenView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/15.
//

import SwiftUI

struct ImportTokenView: View {
	@EnvironmentObject var coordinator: WalletCoordinator
	@StateObject var vm: ImportTokenViewModel = .init()
	
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
					if vm.error != nil {
						HStack {
							Image(systemName: "exclamationmark.triangle.fill")
								.resizable()
								.size(12)
							Text("Invaild ContractAddress")
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
								Link(destination: "https://etherscan.io/token/\(tokenInfo.contractAddress)".toURL) {
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

						BaseButton(
							text: "Import",
							textSize: 16,
							height: 50,
							style: .capsule,
							onPress: vm.onImport
						)
						.padding(.top, 16)
					}

				}
				.padding(.top, 32)
				
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
			.environmentObject(WalletCoordinator(navigationController: .init()))
	}
}
