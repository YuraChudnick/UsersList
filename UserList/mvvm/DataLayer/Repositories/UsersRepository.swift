//
//  UserRepo.swift
//  UserList
//
//  Created by Yurii Chudnovets on 7/24/19.
//  Copyright © 2019 yura. All rights reserved.
//

import PromiseKit
import RealmSwift

protocol UsersRepositoryProtocol {
    func getUsers(page: Int) -> Promise<UsersResponse>
    func getSavedUsers() -> Results<User>
    func save(user: User, with newValues: (first: String, last: String, email: String, phone: String, image: String))
    func delete(user: User)
}

struct UsersRepository: UsersRepositoryProtocol {

    let networkTask: NetworkTaskProtocol
    let realmProvider: RealmProvider
    
    init(networkTask: NetworkTaskProtocol = NetworkTask(), realmProvider: RealmProvider = RealmProvider.users) {
        self.networkTask = networkTask
        self.realmProvider = realmProvider
    }
    
    func getUsers(page: Int) -> Promise<UsersResponse> {
        return networkTask.execute(with: UsersRequest.pagination(page: 1, quantity: 10))
    }
    
    func getSavedUsers() -> Results<User> {
        return realmProvider.realm.objects(User.self)
    }
    
    func save(user: User, with newValues: (first: String, last: String, email: String, phone: String, image: String)) {
        if user.realm != nil {
            user.update(in: realmProvider, with: newValues)
        } else {
            user.fill(with: newValues)
            user.save(in: realmProvider)
        }
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
