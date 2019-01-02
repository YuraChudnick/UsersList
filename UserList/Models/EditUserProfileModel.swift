//
//  EditUserProfileModel.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Foundation
import CoreData

class EditUserProfileModel: EditUserProfileModelProtocol {
    
    private lazy var managedObjectContext = CoreDataStack.managedObjectContex
    
    var userData: UserProtocol?
    
    required init(userData: UserProtocol?) {
        self.userData = userData
    }
    
    func saveItem() {
        if let data = userData as? User {
            _ = UserEntity.with(user: data, in: managedObjectContext)
        }
        managedObjectContext.saveChanges()
    }
    
}
