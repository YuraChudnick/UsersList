//
//  CoreDataStack.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    lazy var managedObjectContex: NSManagedObjectContext = {
        let container = self.persistantContainer
        return container.viewContext
    }()
    
    private lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UsersList")
        container.loadPersistentStores() { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unsolved error: \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
}
