//
//  Picture.swift
//  UserList
//
//  Created by Yurii Chudnovets on 6/14/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RealmSwift

@objcMembers class Picture: Object, Codable {
    
    dynamic var large: String = ""
    dynamic var medium: String = ""
    dynamic var thumbnail: String = ""
    
    enum CodingKeys: String, CodingKey {
        case large
        case medium
        case thumbnail
    }
    
}
