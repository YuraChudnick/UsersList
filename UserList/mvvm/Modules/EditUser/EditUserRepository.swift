//
//  EditUserRepository.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/19/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

protocol EditUserRepositoryProtocol {
    func save(user: User, with newValues: (first: String, last: String, email: String, phone: String, image: String))
}

struct EditUserRepository: EditUserRepositoryProtocol {
    
    let realmProvider: RealmProvider
    
    init(realmProvider: RealmProvider = RealmProvider.users) {
        self.realmProvider = realmProvider
    }

    func save(user: User, with newValues: (first: String, last: String, email: String, phone: String, image: String)) {
        if user.realm != nil {
            user.update(in: realmProvider, with: newValues)
        } else {
            user.fill(with: newValues)
            user.save(in: realmProvider)
        }
    }
    
}
