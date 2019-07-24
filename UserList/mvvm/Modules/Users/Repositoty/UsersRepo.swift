//
//  UserRepo.swift
//  UserList
//
//  Created by Yurii Chudnovets on 7/24/19.
//  Copyright © 2019 yura. All rights reserved.
//

import PromiseKit

class UsersRepo: UsersRepository {
    
    func getUsers(page: Int) -> Promise<UsersResponse> {
        return NewNetworkTask<UsersResponse>(request: GetUsersRequest.pagination(page: 1, quantity: 10)).execute()
    }
    
}
