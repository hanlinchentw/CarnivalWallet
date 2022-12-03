//
//  CoreDataManager.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/31.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
	// MARK: - Properties
	static let sharedInstance = CoreDataManager()
	// MARK: - Save
	func saveContext () {
		self.managedObjectContext.performAndWait {
			if managedObjectContext.hasChanges {
				do {
					try self.managedObjectContext.save()
				} catch {
					let nserror = error as NSError
					fatalError("CoreData: Unresolved error \(nserror), \(nserror.userInfo)")
				}
			}
		}
	}

	private(set) lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "CarnivalWallet")
		container.persistentStoreDescriptions.forEach { storeDesc in
			storeDesc.shouldMigrateStoreAutomatically = true
			storeDesc.shouldInferMappingModelAutomatically = true
		}

		container.loadPersistentStores { description, error in
			if let error = error {
				fatalError("Unable to load persistent stores: \(error)")
			}
		}
		return container
	}()
	
	var managedObjectContext: NSManagedObjectContext {
		return persistentContainer.viewContext
	}
}
