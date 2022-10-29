//
//  Coordinator.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/29.
//

import UIKit

protocol Coordinator: AnyObject {
	var childCoordinators: [Coordinator] { get set }
	var navigationController: UINavigationController { get set }
	
	func start()
}
