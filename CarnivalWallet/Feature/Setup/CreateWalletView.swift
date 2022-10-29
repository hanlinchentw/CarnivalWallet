//
//  CreateWalletView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import SwiftUI

struct CreateWalletView: View {
	@Environment(\.presentationMode) var presentationMode
	@StateObject var vm = InitializeWalletViewModelImpl()
	
	var body: some View {
		ZStack {
			ScrollView() {
				VStack(alignment: .center) {
					Text("This password will unlock your Carnival Wallet only on this device.")
						.AvenirNextRegular(size: 16)
						.multilineTextAlignment(.center)
					
					PasswordInputView(
						password: $vm.passwordText,
						confirmPassword: $vm.confirmPasswordText,
						isBioAuthOn: $vm.isBioAuthOn,
						passwordStrength: vm.passwordStrength
					)
					.padding(.top, 16)

					NavigationLink {
						SecurePhraseView(vm: vm)
					} label: {
						Text("Create")
							.AvenirNextMedium(size: 14)
							.foregroundColor(.white)
					}
					.width(DeviceDimension.WIDTH - 80)
					.height(56)
					.background(.black)
					.clipShape(Capsule())
					.buttonStyle(.plain)
					.disabled(vm.importBtnDisabled)
					.padding(.top, 32)
				}
				.padding(.horizontal, 32)
			}
			.safeAreaInset(.top, inset: UIScreen.height * 0.03)
		}
		.navigationTitle("Create password")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct CreateWalletView_Previews: PreviewProvider {
	static var previews: some View {
		CreateWalletView()
	}
}
