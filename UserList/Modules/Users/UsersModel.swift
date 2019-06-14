//
//  UsersModel.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Foundation

class UsersModel: UsersModelProtocol {
    
    var page: Int = 0
    var usersList: [User] = []
    
    func getData(comlete: @escaping (Bool, Error?) -> Void) {
        NetworkTask<UsersResponse>(request: GetUsersRequest.pagination(page: page, quantity: 10)).execute { [weak self] (response) in
            guard let `self` = self else { return }
            switch response {
            case .data(let data):
                self.usersList += data.results
                self.page += 1
                comlete(true, nil)
            case .error(_ , let error):
                comlete(false, error)
            }
        }
    }
    
}
