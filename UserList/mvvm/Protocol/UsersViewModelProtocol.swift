//
//  UsersViewModelProtocol.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/22/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RxSwift
import RxRelay

protocol UsersViewModelProtocol {
    var userList: BehaviorRelay<[UserViewModel]> { get }
    func selectUser(at indexPath: IndexPath)
    func willDisplayUser(at indexPath: IndexPath)
}

extension UsersViewModelProtocol {
    func willDisplayUser(at indexPath: IndexPath) {}
}
