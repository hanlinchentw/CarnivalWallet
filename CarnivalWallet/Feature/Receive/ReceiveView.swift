//
//  ReceiveView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/29.
//

import SwiftUI

struct ReceiveView: View {
	let QR_CODE_SIZE = DeviceDimension.WIDTH * 0.6

	@EnvironmentObject var navigator: NavigatorImpl
	var coin: Coin
	
	@StateObject var vm = ReceiveViewModel()
	
	var body: some View {
		ZStack {
			Color.gray.opacity(0.1).ignoresSafeArea()
			VStack {
				
				Spacer()
				VStack {
					if let address = vm.account?.address,
						 let qrImage = vm.getQRCode(address: address) {
						Image(uiImage: qrImage)
							.interpolation(.none)
							.resizable()
							.scaledToFit()
							.cornerRadius(16)
							.size(QR_CODE_SIZE)
					}
					Text(vm.account?.address)
						.AvenirNextMedium(size: 16)
						.multilineTextAlignment(.center)
						.foregroundColor(.black.opacity(0.5))
				}
				.width(QR_CODE_SIZE)
				.padding(20)
				.background(Color.white)
				.cornerRadius(16)
				.padding(16)
				.onTapGesture {
					vm.onCopy()
				}
				Group {
					Text("Send only ", coin.name, " (", coin.symbol,")", " to this address.")
						.AvenirNextRegular(size: 16)
					Text("Sending any other coins may result in permanent loss.")
						.AvenirNextRegular(size: 16)
				}
				.lineLimit(0)
				.foregroundColor(Color.black.opacity(0.7))
				.padding(.horizontal, 16)
				
				HStack(spacing: 40) {
					Button {
						vm.onCopy()
					} label: {
						VStack {
							Image(name: "copy")
								.resizable()
								.scaledToFit()
								.size(24)
								.padding()
								.background(Color.white)
								.clipShape(Capsule())
							Text("Copy")
								.AvenirNextMedium(size: 16)
						}
					}.buttonStyle(.plain)

					ShareLink(item: vm.account?.address ?? "") {
						VStack {
							Image(systemName: "square.and.arrow.up")
								.resizable()
								.scaledToFit()
								.size(24)
								.padding()
								.background(Color.white)
								.clipShape(Capsule())
							Text("Share")
								.AvenirNextMedium(size: 16)
						}
					}
					.foregroundColor(.black)
				}
				Spacer()
			}
			.toolbar(.hidden)
			.header(title: "Receive") {
				Image(systemName: "chevron.left")
			} onPressedLeftItem: {
				navigator.pop()
			}
		}
	}
}

struct ReceiveView_Previews: PreviewProvider {
	static var previews: some View {
		ReceiveView(coin: .testETH)
	}
}
