//
//  WelcomeView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import SwiftUI

struct WelcomeView: View {
	var body: some View {
		NavigationView {
			ZStack {
				Color.white
					.ignoresSafeArea()

				VStack{
					Text("Carnival")
						.AvenirNextBold(size: 32)
					Text("Wallet setup")
						.AvenirNextBold(size: 20)
						.padding(.top, 44)
					Text("Import an existing wallet or create a new one")
						.AvenirNextMedium(size: 16)
						.multilineTextAlignment(.center)
						.padding(.top, 8)
					
					Spacer()
					
					bottomButtons
				}
			}
		}
		.accentColor(.black)
	}
	
	var bottomButtons: some View {
		VStack {
			NavigationLink {
				ImportPhraseView()
			} label: {
				Text("Import using Secret Recovery Phrase")
					.AvenirNextMedium(size: 14)
			}
			.foregroundColor(.black)
			.padding()
			.width(DeviceDimension.WIDTH - 80)
			.overlay(
				Capsule(style: .continuous)
					.stroke(Color.black, style: StrokeStyle(lineWidth: 1, dash: []))
			)
			.buttonStyle(.plain)
			
			NavigationLink {
				CreateWalletView()
			} label: {
				Text("Create a new wallet")
					.AvenirNextMedium(size: 14)
			}
			.foregroundColor(.white)
			.padding()
			.width(DeviceDimension.WIDTH - 80)
			.background(.black)
			.clipShape(Capsule())
			.padding(.top, 8)
			.buttonStyle(.plain)
		}
		.padding(.bottom, 32)
	}
}

struct WelcomeView_Previews: PreviewProvider {
	static var previews: some View {
		WelcomeView()
	}
}
