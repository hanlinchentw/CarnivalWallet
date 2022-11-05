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

typealias VoidClosure = () -> Void

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

extension Image {
	init(name: String?) {
		let uiImage = UIImage(named: name ?? "")
		if let uiImage {
			self.init(uiImage: uiImage)
			return
		}
		let systemUIImage = UIImage(systemName: name ?? "")
		if let systemUIImage {
			self.init(uiImage: systemUIImage)
			return
		}
		self.init("")
	}
}

extension Int {
	func toString() -> String {
		return String(self)
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

extension NSManagedObject {
	static func first<T: NSManagedObject>(_ context: NSManagedObjectContext) throws -> T? {
		return try self.allIn(context).first
	}
	
	static func allIn<T: NSManagedObject>(_ context: NSManagedObjectContext) throws -> Array<T> {
		return try self.fetchWithCondition(for: nil, in: context)
	}
	static func find<T: NSManagedObject>(for condition: Dictionary<String, String>, in context: NSManagedObjectContext) throws -> Array<T> {
		return try self.fetchWithCondition(for: condition, in: context)
	}
	
	static func save(in context: NSManagedObjectContext) throws {
		return try context.save()
	}
	
	func delete(in context: NSManagedObjectContext) {
		return context.delete(self)
	}
	
	static func deleteAll(in context: NSManagedObjectContext) throws {
		try self.allIn(context).forEach { result in
			result.delete(in: context)
		}
	}
}

extension NSManagedObject {
	static func fetchWithCondition<T>(for condition: Dictionary<String, String>?, in context: NSManagedObjectContext) throws -> Array<T> {
		let request = self.fetchRequest()
		request.returnsObjectsAsFaults = false
		if let condition = condition {
			let predicates: Array<NSPredicate> = condition.map { key, value in
				return NSPredicate(format: "%K = %@", key, value)
			}
			let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
			request.predicate = compoundPredicate
		}
		return try context.fetch(request) as! Array<T>
	}
}

extension Task where Success == Never, Failure == Never {
	static func sleep(seconds: Double) async throws {
		let duration = UInt64(seconds * 1_000_000_000)
		try await Task.sleep(nanoseconds: duration)
	}
}
