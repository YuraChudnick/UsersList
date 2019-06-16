//
//  SavedUsersModelProtocol.swift
//  UserList
//
//  Created by yura on 6/15/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation
import RealmSwift

protocol SavedUsersModelProtocol {
    
    func getRealm() -> Realm
    func getUsers() -> [User]
    
}
