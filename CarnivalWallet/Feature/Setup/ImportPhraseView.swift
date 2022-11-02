//
//  ImportPhraseView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import SwiftUI

struct ImportPhraseView: View {
	@EnvironmentObject var coordinator: SetupCoordinator
	@Environment(\.presentationMode) var presentationMode
	@StateObject var vm = InitializeWalletViewModelImpl()
	
	init() {
		UINavigationBar.appearance().titleTextAttributes = .bold24
	}
	
	var body: some View {
		ZStack {
			Color.white
				.ignoresSafeArea()

			ScrollView() {
				VStack(alignment: .center) {
					PhraseInputView(phrase: $vm.phrase, phraseValid: vm.isPhraseValid)
					
					PasswordInputView(
						password: $vm.passwordText,
						confirmPassword: $vm.confirmPasswordText,
						isBioAuthOn: $vm.isBioAuthOn,
						passwordStrength: vm.passwordStrength
					)

					BaseButton(
						text: "Import",
						width: DeviceDimension.WIDTH - 80,
						height: 56,
						disabled: vm.importBtnDisabled,
						style: .capsule) {
							vm.importWallet()
							coordinator.finishSetup()
						}
						.padding(.top, 32)
				}
				.padding(.horizontal, 32)
			}
			.safeAreaInset(.top, inset: UIScreen.height * 0.03)
		}
		.tapToResign()
		.navigationTitle("Import from seed")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct ImportPhraseView_Previews: PreviewProvider {
	static var previews: some View {
		ImportPhraseView()
	}
}
