//
//  ScannerViewController.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/16.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController {
	weak var delegate: ScannerViewControllerDelegate?
	private let closeButton: UIButton = {
		var config = UIButton.Configuration.plain()
		config.image = UIImage(systemName: "xmark")
		config.baseForegroundColor = .white
		let button = UIButton(configuration: config)
		button.addTarget(self, action: #selector(handleCloseButtonTapped), for: .touchUpInside)
		return button
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Scan QR code"
		label.textColor = .white
		label.font = UIFont.AvenirNextMedium(size: 16)
		return label
	}()
	
	var captureSession: AVCaptureSession?
	var videoPreviewLayer: AVCaptureVideoPreviewLayer?
	var qrCodeFrameView: UIView?
	var didFinishScanning = false
	var lastTime = Date(timeIntervalSince1970: 0)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let	device = AVCaptureDevice.default(for: .video) else {
			return
		}
		
		guard let input = try? AVCaptureDeviceInput.init(device: device) else {
			return
		}
		captureSession = AVCaptureSession()
		captureSession?.addInput(input)
		
		let captureMetadataOutput = AVCaptureMetadataOutput()
		captureSession?.addOutput(captureMetadataOutput)
		
		
		captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
		captureMetadataOutput.metadataObjectTypes = [.qr]
		
		videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
		
		videoPreviewLayer?.videoGravity = .resizeAspectFill
		videoPreviewLayer?.frame = view.layer.bounds
		view.layer.addSublayer(videoPreviewLayer!)
		
		setupBackgroundBlurView()
		setupCloseButton()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if (captureSession?.isRunning == false) {
			DispatchQueue.global(qos: .userInteractive).async {
				self.captureSession?.startRunning()
			}
		}
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		if (captureSession?.isRunning == true) {
			DispatchQueue.global(qos: .userInteractive).async {
				self.captureSession?.stopRunning()
			}
		}
	}
	
	@objc func handleCloseButtonTapped() {
		delegate?.didFinish()
	}
	
	func setupBackgroundBlurView() {
		let blur = UIBlurEffect(style: .light)
		let blurView = UIVisualEffectView(effect: blur)
		blurView.frame = self.view.bounds
		self.view.addSubview(blurView)
		
		let maskView = UIView(frame: blurView.bounds)
		maskView.clipsToBounds = true;
		maskView.backgroundColor = UIColor.clear
		let outerbezierPath = UIBezierPath.init(roundedRect: blurView.bounds, cornerRadius: 0)
		let rect = CGRect(x: self.view.frame.midX - (300/2), y: self.view.frame.midY - (300/2) - 100, width: 300, height: 300)
		let innerCirclepath = UIBezierPath.init(roundedRect: rect, cornerRadius: 36)
		outerbezierPath.append(innerCirclepath)
		outerbezierPath.usesEvenOddFillRule = true
		
		let fillLayer = CAShapeLayer()
		fillLayer.fillRule = .evenOdd
		fillLayer.fillColor = UIColor.white.cgColor // any opaque color would work
		fillLayer.path = outerbezierPath.cgPath
		maskView.layer.addSublayer(fillLayer)
		
		blurView.mask = maskView;
	}
	
	func setupCloseButton() {
		view.addSubview(closeButton)
		closeButton.translatesAutoresizingMaskIntoConstraints = false
		closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
		closeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
		closeButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
		closeButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
	}
}

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
	func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
		guard let metadataObj = metadataObjects.first else {
			return
		}
		guard let readableObject = metadataObj as? AVMetadataMachineReadableCodeObject else { return }
		guard let stringValue = readableObject.stringValue else { return }
		guard didFinishScanning == false else { return }
		
		didFinishScanning = true
		report(stringValue)
	}
	
	func report(_ stringValue: String) {
		lastTime = Date()
		AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
		self.captureSession?.stopRunning()
		self.delegate?.didCaptureCode(stringValue)
	}
}
