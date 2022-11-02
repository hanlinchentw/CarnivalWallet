//
//  Utilities.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/26.
//

import Foundation
import UIKit
import SwiftUI
import CoreData

class ObjectUtils {
	static func checkNotNil<T>(_ object: T?, message: String) throws -> T {
		if (object == nil) {
			throw NSError(domain: message, code: 0)
		}
		return object!
	}
}

extension NSManagedObjectContext {
	static var defaultContext: NSManagedObjectContext {
		CoreDataManager.sharedInstance.managedObjectContext
	}
}

extension Text {
	init(_ text: String?) {
		
		self.init(verbatim: text ?? "")
	}
}

extension Double {
	func toString() -> String {
		return String(format: "%.1f", self)
	}
}

extension String {
	func plus(_ string: String = "") -> String {
		return (Double(self)! + Double(string)!).toString()
	}
	
	func minus(_ string: String = "") -> String {
		return (Double(self)! - Double(string)!).toString()
	}
	
	func time(_ string: String = "") -> String {
		return (Double(self)! * Double(string)!).toString()
	}
	
	func divide(_ string: String = "") -> String {
		return (Double(self)! / Double(string)!).toString()
	}
}
