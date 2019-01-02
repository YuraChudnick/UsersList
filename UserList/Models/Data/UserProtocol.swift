//
//  UserProtocol.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit

protocol UserProtocol {
    
    func getFirstName() -> String
    func getLastName()  -> String
    func getGender()    -> String
    func getEmail()     -> String
    func getPhone()     -> String
    func getImage()     -> UIImage?
    func getImageName() -> String?
    
    mutating func setFirstName(first: String)
    mutating func setLastName(last: String)
    mutating func setEmail(email: String)
    mutating func setPhone(phone: String)
    mutating func setImage(image: UIImage)
    
}
