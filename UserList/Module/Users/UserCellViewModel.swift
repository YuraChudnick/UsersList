//
//  UserCellViewModel.swift
//  UserList
//
//  Created by yura on 6/14/19.
//  Copyright © 2019 yura. All rights reserved.
//

import DifferenceKit

struct UserCellViewModel {
    
    var name: String
    var phome: String
    var imageUrl: URL?
    
    init(user: User) {
        var name = ""
        if let n = user.name {
            name = n.first.capitalizingFirstLetter() + " " + n.last.capitalizingFirstLetter()
        }
        self.name = name
        phome = user.phone
        imageUrl = URL(string: user.picture?.large ?? "")
    }
    
}

typealias UsersStore = Store<UsersState, Action>

extension UUID: Differentiable { }
