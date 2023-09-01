// CoreDataStack.swift
// Reciplease
//
// Created by Stephane Lefebvre on 7/23/23.

import Foundation
import CoreData

class CoreDataStack {
    let persistentContainer: NSPersistentContainer
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        
        // Explicitly set to NSSQLiteStoreType for persistent storage
        let storeDescription = NSPersistentStoreDescription()
        storeDescription.type = NSSQLiteStoreType
        
        persistentContainer.persistentStoreDescriptions = [storeDescription]

        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
