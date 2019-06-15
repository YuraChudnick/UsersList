//
//  UsersModel2.swift
//  UserList
//
//  Created by Yurii Chudnovets on 6/14/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation

class UsersModel: UsersModelProtocol {
    
    func getUsers(page: Int, complete: @escaping (Response<UsersResponse>) -> Void) {
        NetworkTask<UsersResponse>(request: GetUsersRequest.pagination(page: page, quantity: 10)).execute(completionHandler: complete)
    }
    
}
