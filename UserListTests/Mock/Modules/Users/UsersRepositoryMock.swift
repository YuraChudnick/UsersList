//
//  UsersRepositoryMock.swift
//  UserListTests
//
//  Created by yura on 9/1/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RealmSwift
import PromiseKit
@testable import UserList

class UsersRepositoryMock: UsersRepositoryProtocol {
    var isCalledGetUser = false
    var page = -1
    
    let realmProvider = RealmProvider.usersTest
    
    func getUsers(page: Int) -> Promise<UsersResponse> {
        let user = User()
        user.fillMockData()
        var response = UsersResponse()
        response.results.append(user)
        self.page = page
        return Promise { seal in
            if page == 2 {
                seal.reject(NetworkError.unknown(reason: "unknown"))
            } else {
                seal.fulfill(response)
            }
        }
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
        guard user.realm != nil else { return }
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
