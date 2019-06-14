//
//  UsersPresenterProtocol.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Foundation

protocol UsersPresenterProtocol: class {
    
    init(view: UsersViewProtocol, model: UsersModelProtocol)
    
    func didRefreshUsersList()
    
}
