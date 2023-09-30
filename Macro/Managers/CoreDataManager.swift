//
//  CoreDataManager.swift
//  Macro
//
//  Created by Eric on 9/28/23.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
    private var persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Meeting")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
}
