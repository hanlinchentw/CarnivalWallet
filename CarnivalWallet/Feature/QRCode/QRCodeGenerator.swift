//
//  QRCodeGenerator.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/29.
//

import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeDataSet {
	let logo: UIImage?
	let string: String
	let size: CGSize
	
	init(logo: UIImage? = nil, string: String) {
		self.logo = logo
		self.string = string
		self.size = .init(width: 300, height: 300)
	}
}

class QRCodeGenerator {
	let context = CIContext()
	let filter = CIFilter.qrCodeGenerator()
	let set: QRCodeDataSet
	
	init(set: QRCodeDataSet) {
		self.set = set
	}
	
	private func createCIImage() -> CIImage? {
		filter.message = Data(set.string.utf8)
		
		guard let outputImage = filter.outputImage else {
			return nil
		}
		let scaleX = set.size.width / outputImage.extent.size.width
		let scaleY = set.size.height / outputImage.extent.size.height
		outputImage.transformed(by: .init(scaleX: scaleX, y: scaleY))
		return outputImage
	}
	
	private func addLogo(image: CIImage, logo: UIImage) -> CIImage? {
		guard let logo = logo.cgImage else {
			return image
		}
		let ciLogo = CIImage(cgImage: logo)
		let centerTransform = CGAffineTransform(translationX: image.extent.midX - (ciLogo.extent.size.width / 2), y: image.extent.midY - (ciLogo.extent.size.height / 2))
		let combinedFilter = CIFilter.sourceOverCompositing()
		combinedFilter.inputImage = ciLogo.transformed(by: centerTransform)
		combinedFilter.backgroundImage = image
		return combinedFilter.outputImage
	}
	
	func create() -> UIImage? {
		guard let ciImage = createCIImage() else {
			return nil
		}
		guard let logo = set.logo,
					let codeWithCenteredLogo = addLogo(image: ciImage, logo: logo) else {
			guard let cgimg = context.createCGImage(ciImage, from: ciImage.extent) else {
				return nil
			}
			return UIImage(cgImage: cgimg)
		}
		
		guard let cgimg = context.createCGImage(codeWithCenteredLogo, from: codeWithCenteredLogo.extent) else {
			return nil
		}
		return UIImage(cgImage: cgimg)
	}
}
