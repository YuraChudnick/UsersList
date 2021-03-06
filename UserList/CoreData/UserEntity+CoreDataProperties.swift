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

extension UserEntity: UserProtocol {

    func getFirstName() -> String {
        return first_name
    }
    
    func getLastName() -> String {
        return last_name
    }
    
    func getGender() -> String {
        return gender
    }
    
    func getEmail() -> String {
        return email
    }
    
    func getPhone() -> String {
        return phone
    }
    
    func getImage() -> UIImage? {
        return image
    }
    
    func getImageName() -> String? {
        return nil
    }
    
    func getImageData() -> NSData? {
        return photo
    }
    
    func setFirstName(first: String) {
        first_name = first
    }
    
    func setLastName(last: String) {
        last_name = last
    }
    
    func setEmail(email: String) {
        self.email = email
    }
    
    func setPhone(phone: String) {
        self.phone = phone
    }
    
    func setImage(data: NSData?) {
        photo = data
    }
    
}

extension UserEntity {
    static var entityName: String {
        return String(describing: UserEntity.self)
    }
    
    @nonobjc class func with(user: User, in context: NSManagedObjectContext) -> UserEntity {
        let userEntity = NSEntityDescription.insertNewObject(forEntityName: UserEntity.entityName, into: context) as! UserEntity
        
        if let name = user.name {
            userEntity.first_name = name.first
            userEntity.last_name = name.last
        } else {
            userEntity.first_name = ""
            userEntity.last_name = ""
        }
        userEntity.gender = user.gender
        userEntity.email = user.email
        userEntity.phone = user.phone
        userEntity.photo = user.getImageData()
        
        return userEntity
    }
}

extension UserEntity {
    var image: UIImage? {
        return self.photo != nil ? UIImage(data: self.photo! as Data) : nil
    }
}
