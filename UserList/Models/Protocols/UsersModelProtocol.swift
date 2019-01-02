//
//  UsersModelProtocol.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Foundation

protocol UsersModelProtocol: class {
    
    var page: Int { get }

    var usersList: [User] { get }
    
    func getData(comlete: @escaping (Bool, Error?) -> Void)
    
}
