//
//  Name.swift
//  UserList
//
//  Created by Yurii Chudnovets on 6/14/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RealmSwift

@objcMembers class Name: Object, Codable {
    
    dynamic var title: String = ""
    dynamic var first: String = ""
    dynamic var last: String  = ""
    
    enum CodingKeys: String, CodingKey {
        case title
        case first
        case last
    }
    
}
