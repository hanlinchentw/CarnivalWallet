//
//  Divider.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/24.
//

import UIKit

class DividerView: UIView {
	init(height: CGFloat = 1, color: UIColor = .black.withAlphaComponent(0.7)) {
		super.init(frame: .zero)
		heightAnchor.constraint(equalToConstant: height).isActive = true
		backgroundColor = color
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	enum Width {
		case full
		case partial(percentage: CGFloat)
	}
}

extension UIView {
	func addBottomDivider(height: CGFloat = 1, width: DividerView.Width, color: UIColor = .black.withAlphaComponent(0.7), completion: ((UIView) -> Void)? = nil) {

		let divider = DividerView(height: height, color: color)
		addSubview(divider)
		divider.translatesAutoresizingMaskIntoConstraints = false
		divider.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 8).isActive = true
		divider.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		
		switch width {
		case .full:
			divider.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
		case .partial(let percentage):
			divider.widthAnchor.constraint(equalTo: widthAnchor, multiplier: percentage).isActive = true
		}

		completion?(divider)
	}
}
