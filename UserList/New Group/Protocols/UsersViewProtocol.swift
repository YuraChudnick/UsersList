//
//  UsersViewProtocol.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Foundation

protocol UsersViewProtocol: class {
    
    func setUsersList(list: [User])
    func manualRefresh()
    func stopRefreshing()
    func showHideNoDataLabel(show: Bool)
    
}
