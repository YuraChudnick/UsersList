//
//  UsersRouterMock.swift
//  UserListTests
//
//  Created by yura on 9/1/19.
//  Copyright © 2019 yura. All rights reserved.
//

@testable import UserList

class UsersRouterMock: UsersRouterProtocol {
    
    var user: User?
    
    func presentEditScreen(with user: User) {
        self.user = user
    }
    
}

