//
//  CoreDataStack.swift
//  Dog Walk
//
//  Created by Pavel Ivanov on 9/5/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import CoreData

class CoreDataStack {
    
    fileprivate let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var managerContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    fileprivate lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
