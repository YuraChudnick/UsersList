//
//  UsersResponse.swift
//  UserList
//
//  Created by Yurii Chudnovets on 6/14/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation

struct UsersResponse: Codable {
    
    var results: [User] = []
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
}
