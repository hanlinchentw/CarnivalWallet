//
//  Navigator.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/30.
//

import Foundation
import SwiftUI

protocol Navigator: AnyObject {
	var path: NavigationPath { get set }
	func navigate(to: RouteName)
	func pop()
	func popToTop()
}

extension Navigator {
	func navigate(to: RouteName) {
		path.append(to)
	}
	
	func pop() {
		path.removeLast()
	}
	
	func popToTop() {
		path.removeLast(path.count)
	}
}
