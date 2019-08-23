//
//  RealmProvider.swift
//  UserList
//
//  Created by Yurii Chudnovets on 6/14/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmProvider {
    let configuration: Realm.Configuration
    
    init(config: Realm.Configuration) {
        configuration = config
    }
    
    var realm: Realm {
        return try! Realm(configuration: configuration)
    }
    
    private static let usersConfig = Realm.Configuration(fileURL: try! Path.inDocuments("users.realm"),
                                                         schemaVersion: 1,
                                                         deleteRealmIfMigrationNeeded: true,
                                                         objectTypes: [User.self, Name.self, Picture.self])
    
    static var users: RealmProvider = {
        RealmProvider(config: usersConfig)
    }()
    
}
