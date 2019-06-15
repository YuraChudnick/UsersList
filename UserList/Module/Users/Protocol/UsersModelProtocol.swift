//
//  UsersModelProtocol2.swift
//  UserList
//
//  Created by Yurii Chudnovets on 6/14/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation

protocol UsersModelProtocol {
    
    func getUsers(page: Int, complete: @escaping (Response<UsersResponse>) -> Void)
    
}
