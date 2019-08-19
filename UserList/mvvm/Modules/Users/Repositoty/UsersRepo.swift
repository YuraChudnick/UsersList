//
//  UserRepo.swift
//  UserList
//
//  Created by Yurii Chudnovets on 7/24/19.
//  Copyright © 2019 yura. All rights reserved.
//

import PromiseKit

class UsersRepo: UsersRepository {
    
    let networkTask: NewNetworkTaskProtocol
    
    init(networkTask: NewNetworkTaskProtocol) {
        self.networkTask = networkTask
    }
    
    func getUsers(page: Int) -> Promise<UsersResponse> {
        return networkTask.execute(with: GetUsersRequest.pagination(page: 1, quantity: 10))
    }
    
}
