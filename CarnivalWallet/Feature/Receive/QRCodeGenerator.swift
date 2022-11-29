//
//  QRCodeGenerator.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/29.
//

import UIKit
import CoreImage

struct QRCodeDataSet {
	let logo: UIImage?
	let string: String
	let backgroundColor: CIColor
	let color: CIColor
	let size: CGSize
	
	init(logo: UIImage? = nil, string: String) {
		self.logo = logo
		self.string = string
		self.backgroundColor = CIColor(red: 1, green: 1, blue: 1)
		self.color = CIColor(red: 1,green: 0.46,blue: 0.46)
		self.size = CGSize(width: 300, height: 300)
	}
}

class QRCodeGenerator {
	let set: QRCodeDataSet
	
	init(set: QRCodeDataSet) {
		self.set = set
	}
	
	private func createCIImage() -> CIImage? {
		guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
			return nil
		}
		filter.setDefaults()
		filter.setValue(set.string.data(using: String.Encoding.ascii), forKey: "inputMessage")
		filter.setValue("H", forKey: "inputCorrectionLevel")
		return filter.outputImage
	}
	
	private func updateColor(image: CIImage) -> CIImage? {
		guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
		
		colorFilter.setValue(image, forKey: kCIInputImageKey)
		colorFilter.setValue(set.color, forKey: "inputColor0")
		colorFilter.setValue(set.backgroundColor, forKey: "inputColor1")
		return colorFilter.outputImage
	}
	
	private func addLogo(image: CIImage, logo: UIImage) -> CIImage? {
		
		guard let combinedFilter = CIFilter(name: "CISourceOverCompositing") else { return nil }
		guard let logo = logo.cgImage else {
			return image
		}
		
		let ciLogo = CIImage(cgImage: logo)
		let centerTransform = CGAffineTransform(translationX: image.extent.midX - (ciLogo.extent.size.width / 2), y: image.extent.midY - (ciLogo.extent.size.height / 2))
		
		combinedFilter.setValue(ciLogo.transformed(by: centerTransform), forKey: "inputImage")
		combinedFilter.setValue(image, forKey: "inputBackgroundImage")
		return combinedFilter.outputImage
	}
	
	func create() -> UIImage? {
		guard let ciImage = createCIImage() else {
			return nil
		}
		guard let colorfulImage = updateColor(image: ciImage) else {
			return UIImage(ciImage: ciImage)
		}
		guard let logo = set.logo,
			 let codeWithCenteredLogo = addLogo(image: colorfulImage, logo: logo) else {
			return UIImage(ciImage: colorfulImage)
		}
		return UIImage(ciImage: codeWithCenteredLogo)
	}
}
