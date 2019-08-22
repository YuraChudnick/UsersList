//
//  UserCellViewModelCreating.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/22/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation

protocol UserCellViewModelCreating {
    func createUserCellViewModel(user: User) -> UserCellViewModel
}

extension UserCellViewModelCreating {
    
    func createUserCellViewModel(user: User) -> UserCellViewModel {
        var name = ""
        if let n = user.name {
            name = n.first.capitalizingFirstLetter() + " " + n.last.capitalizingFirstLetter()
        }
        
        return UserCellViewModel(name: name,
                                 phome: user.phone,
                                 imageUrl: URL(string: user.picture?.large ?? ""))
    }
    
}
