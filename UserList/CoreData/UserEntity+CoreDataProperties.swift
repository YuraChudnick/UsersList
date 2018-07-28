//
//  User+CoreDataProperties.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//
//

import Foundation
import UIKit
import CoreData

extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "first_name", ascending: true)]
        return request
    }

    @NSManaged public var first_name: String
    @NSManaged public var last_name: String
    @NSManaged public var gender: String
    @NSManaged public var email: String
    @NSManaged public var phone: String
    @NSManaged public var photo: NSData?

}

extension UserEntity {
    static var entityName: String {
        return String(describing: UserEntity.self)
    }
    
    @nonobjc class func with(user: User, _ image: UIImage?, in context: NSManagedObjectContext) -> UserEntity {
        let userEntity = NSEntityDescription.insertNewObject(forEntityName: UserEntity.entityName, into: context) as! UserEntity
        
        if let name = user.name {
            userEntity.first_name = name.first.capitalizingFirstLetter()
            userEntity.last_name = name.last.capitalizingFirstLetter()
        } else {
            userEntity.first_name = ""
            userEntity.last_name = ""
        }
        userEntity.gender = user.gender
        userEntity.email = user.email
        userEntity.phone = user.phone
        if image != nil {
            userEntity.photo = UIImageJPEGRepresentation(image!, 1.0)! as NSData
        }
        
        return userEntity
    }
}

extension UserEntity {
    var image: UIImage {
        return self.photo != nil ? UIImage(data: self.photo! as Data)! : UIImage()
    }
}
