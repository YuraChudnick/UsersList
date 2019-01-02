//
//  AppDelegate.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        
        //window?.backgroundColor = .white
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }

    lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UsersList")
        container.loadPersistentStores() { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unsolved error: \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()

}

