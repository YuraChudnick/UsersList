//
//  SavedUsersViewModelMock.swift
//  UserListTests
//
//  Created by Yurii Chudnovets on 8/28/19.
//  Copyright © 2019 yura. All rights reserved.
//

import XCTest
@testable import UserList

class SavedUsersViewModelMock: SavedUsersViewModelProtocol {
    
    var usersStore: UsersStore
    
    init() {
        let userState = UsersState(viewModels: [UserViewModel(user: User())])
        usersStore = UsersStore(initialState: userState, reducer: update)
    }
    
}
