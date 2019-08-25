//
//  UserRepo.swift
//  UserList
//
//  Created by Yurii Chudnovets on 7/24/19.
//  Copyright © 2019 yura. All rights reserved.
//

import PromiseKit

protocol UsersRepositoryProtocol {
    func getUsers(page: Int) -> Promise<UsersResponse>
}

class UsersRepository: UsersRepositoryProtocol {
    
    let networkTask: NetworkTaskProtocol
    
    init(networkTask: NetworkTaskProtocol) {
        self.networkTask = networkTask
    }
    
    func getUsers(page: Int) -> Promise<UsersResponse> {
        return networkTask.execute(with: UsersRequest.pagination(page: 1, quantity: 10))
    }
    
}
