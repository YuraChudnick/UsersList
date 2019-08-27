//
//  RealmForTesting.swift
//  UserListTests
//
//  Created by yura on 8/27/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Realm
import RealmSwift
import XCTest
@testable import UserList

protocol RealmForTesting {
    func deleteAllFromRealm()
}

extension RealmForTesting where Self: XCTestCase {
    
    func deleteAllFromRealm() {
        let realm = RealmProvider.usersTest.realm
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }
    
}
