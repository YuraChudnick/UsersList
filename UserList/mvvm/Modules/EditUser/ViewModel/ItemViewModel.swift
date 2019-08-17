//
//  ItemViewModel.swift
//  UserList
//
//  Created by yura on 7/25/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RxSwift
import RxCocoa

enum ItemType: String {
    case firstName = "First name"
    case lastName  = "Last name"
    case email     = "Email"
    case phone     = "Phone"
}

class ItemViewModel {
    
    let editUserProfileRepository: EditUserProfileRepositoty
    //let type = 
    
    init(editUserProfileRepository: EditUserProfileRepositoty, type: ItemType) {
        self.editUserProfileRepository = editUserProfileRepository
    }
    
}
