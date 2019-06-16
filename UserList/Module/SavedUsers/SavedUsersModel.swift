//
//  SavedUsersModel.swift
//  UserList
//
//  Created by yura on 6/15/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation
import RealmSwift

class SavedUsersModel: SavedUsersModelProtocol {
    
    func getRealm() -> Realm {
        return RealmProvider.users.realm
    }
    
    func getUsers() -> [User] {
        var users: [User] = []
        let results = RealmProvider.users.realm.objects(User.self)
        results.forEach { users.append($0) }
        return users
    }
    
}
