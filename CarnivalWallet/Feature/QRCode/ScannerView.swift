//
//  ScannerView.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/16.
//

import SwiftUI
import UIKit

protocol ScannerViewControllerDelegate: AnyObject {
	func didCaptureCode(_ result: String)
	func didFinish()
}

struct ScannerView: UIViewControllerRepresentable {
	var onScan: (_ qrCode: String) -> Void
	var onClose: VoidClosure
	
	typealias UIViewControllerType = ScannerViewController
	
	func makeUIViewController(context: Context) -> UIViewControllerType {
		let vc = ScannerViewController()
		vc.delegate = context.coordinator
		return vc
	}
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
	}
	
	func makeCoordinator() -> ScannerView.Coordinator {
		return Coordinator(self)
	}
}

extension ScannerView {
	class Coordinator: NSObject, ScannerViewControllerDelegate {
		var parent: ScannerView
		
		init(_ parent: ScannerView) {
			self.parent = parent
		}
		
		func didCaptureCode(_ result: String) {
			parent.onScan(result)
		}
		
		func didFinish() {
			parent.onClose()
		}
	}
}
