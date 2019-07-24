//
//  UsersRepository.swift
//  UserList
//
//  Created by Yurii Chudnovets on 7/24/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation
import PromiseKit

protocol UsersRepository {
    
    func getUsers(page: Int) -> Promise<UsersResponse>
    
}
