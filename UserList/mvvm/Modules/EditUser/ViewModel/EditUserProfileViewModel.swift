//
//  EditUserProfileViewModel.swift
//  UserList
//
//  Created by yura on 8/17/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation

protocol EditUserProfileViewModelProtocol {
    func pressedChangeAvatar()
}

class EditUserProfileViewModel: EditUserProfileViewModelProtocol {
    
    let repository: EditUserRepositoryProtocol
    var router: EditUserRouterProtocol!
    
    init(repository: EditUserRepositoryProtocol) {
        self.repository = repository
    }
    
    func pressedChangeAvatar() {
        router.presentPhotoPicker()
    }
    
}
