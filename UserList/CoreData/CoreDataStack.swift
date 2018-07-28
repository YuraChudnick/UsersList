//
//  CoreDataStack.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack {
    
    static var managedObjectContex: NSManagedObjectContext = {
        //let container = self.persistantContainer
        let container = (UIApplication.shared.delegate as! AppDelegate).persistantContainer
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

extension NSManagedObjectContext {
    func saveChanges() {
        if self.hasChanges {
            do {
                try save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
