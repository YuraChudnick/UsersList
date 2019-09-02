//
//  UserViewModelMock.swift
//  UserListTests
//
//  Created by Yurii Chudnovets on 9/2/19.
//  Copyright © 2019 yura. All rights reserved.
//

import XCTest
import RxSwift
import RxRelay
@testable import UserList

class UserViewModelMock: UsersViewModelProtocol {
    
    var userList: BehaviorRelay<[UserViewModel]> = BehaviorRelay<[UserViewModel]>(value: [])
    var loadTrigger: PublishRelay<Void> = PublishRelay<Void>()
    var isRefreshing: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)
    
    func selectUser(at indexPath: IndexPath) {
        
    }
    
    func willDisplayUser(at indexPath: IndexPath) {
        
    }
    
}
