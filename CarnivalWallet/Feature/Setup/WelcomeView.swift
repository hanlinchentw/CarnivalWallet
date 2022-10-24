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
				VStack{
					Text("Carnival")
						.font(.custom("CourierNewPS-BoldMT", fixedSize: 24))
					Text("Wallet setup")
						.bold(size: 20)
						.padding(.top, 44)
					Text("Import an existing wallet or create a new one")
						.medium16()
						.multilineTextAlignment(.center)
						.padding(.top, 8)
					
					Spacer()
					
					bottomButtons
				}
			}
		}
	}
	
	var bottomButtons: some View {
		VStack {
			NavigationLink {
				ImportPhraseView()
			} label: {
				Text("Import using Secret Recovery Phrase").medium14()
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
				Text("Create a new wallet").medium14()
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
