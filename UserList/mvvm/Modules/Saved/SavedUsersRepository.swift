//
//  SavedUsersRepository.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/22/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Realm
import RealmSwift

protocol SavedUsersRepositoryProtocol {
    func getSavedUsers() -> Results<User>
    func delete(user: User)
}

struct SavedUsersRepository: SavedUsersRepositoryProtocol {
    
    let realmProvider: RealmProvider

    init(realmProvider: RealmProvider = RealmProvider.users) {
        self.realmProvider = realmProvider
    }
    
    func getSavedUsers() -> Results<User> {
        return realmProvider.realm.objects(User.self)
    }
    
    func delete(user: User) {
        let realm = realmProvider.realm
        do {
            try realm.write {
                realm.delete(user)
            }
        } catch {
            print(error)
        }
    }
    
}
