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
		precondition(object != nil, message)
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
	
	init(_ args: String?...) {
		let string = args.compactMap { $0 }.reduce("", { $0 + $1 })
		self.init(string)
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

extension String: Error {}

extension String: LocalizedError {
	public var errorDescription: String? { return self }
}

extension String {
	func addPrefix(_ prefix: String) -> String {
		return prefix + self
	}
	
	func deletePrefix(_ prefix: String) -> String {
		guard self.hasPrefix(prefix) else { return self }
		return String(self.dropFirst(prefix.count))
	}
	
	var add0x: String {
		self.addPrefix("0x")
	}
	
	var drop0x: String {
		self.deletePrefix("0x")
	}
}
extension String {
	subscript(i: Int) -> String {
		return String(self[index(startIndex, offsetBy: i)])
	}
}

extension String {
	func padStart(length: Int, with string: String) -> String {
		self.padding(toLength: length, withPad: string, startingAt: 0)
	}
	
	func padEnd(length: Int, with string: String) -> String {
		String (
			String(self.reversed()).padding(toLength: length, withPad: string, startingAt: 0).reversed()
		)
	}
	
	func padZeroToEvenLength() -> String {
		var string = self
		if string.count % 2 != 0 {
			string = "0" + string
		}
		return string
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

extension Data {
	func toString() -> String? {
		return String(data: self, encoding: .utf8)
	}
}

extension String {
	var parseHex: String? {
		let data = Data(hexString: self)
		return data?.toString()
	}
}

extension String {
	func index(from: Int) -> Index {
		return self.index(startIndex, offsetBy: from)
	}
	
	func substring(from: Int) -> String {
		let fromIndex = index(from: from)
		return String(self[fromIndex...])
	}
	
	func substring(to: Int) -> String {
		let toIndex = index(from: to)
		return String(self[..<toIndex])
	}
	
	func substring(with r: Range<Int>) -> String {
		let startIndex = index(from: r.lowerBound)
		let endIndex = index(from: r.upperBound)
		return String(self[startIndex..<endIndex])
	}
}

extension String {
	func trimPrefix0() -> String {
		self.replacingOccurrences(of: "^(0+)", with: "", options: .regularExpression)
	}
	
	func trimSuffix0() -> String {
		self.replacingOccurrences(of: "(0+)$", with: "", options: .regularExpression)
	}
}

extension String {
	func toInt() -> Int {
		Int(self) ?? 0
	}
	
	func toDouble() -> Double {
		Double(self) ?? 0
	}
}

extension NSSet {
	func toArray<T>(_ of:  T.Type) -> Array<T> {
		return self.allObjects as! Array<T>
	}
}

extension Int16 {
	func toInt() -> Int {
		return Int(self)
	}
}

extension Int {
	func toInt16() -> Int16 {
		return Int16(self)
	}
}

extension Formatter {
	static let number = NumberFormatter()
	
	static let withSeparator: NumberFormatter = {
		let formatter = NumberFormatter()
		let locale = Locale.current
		let groupingSeparator = locale.groupingSeparator ?? ","
		formatter.numberStyle = .decimal
		formatter.groupingSeparator = groupingSeparator
		return formatter
	}()
}

extension Numeric {
	func formatted(with groupingSeparator: String? = nil, style: NumberFormatter.Style, locale: Locale = .current) -> String {
		Formatter.number.locale = locale
		Formatter.number.numberStyle = style
		if let groupingSeparator = groupingSeparator {
			Formatter.number.groupingSeparator = groupingSeparator
		}
		return Formatter.number.string(for: self) ?? ""
	}
	
	var currency: String { formatted(style: .currency) }
}

class SafeAreaUtils {
	static var safeAreaInsets: UIEdgeInsets? {
		let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
		return window?.safeAreaInsets
	}
	
	static var top: CGFloat {
		safeAreaInsets?.top ?? 0.0
	}
}
