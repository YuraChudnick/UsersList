//
//  SavedUsersModuleBuilder.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/22/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

struct SavedUsersModuleBuilder {
    
    func create() -> UIViewController {
        let vm = SavedUsersViewModel(repository: UsersRepository())
        let vc = SavedUsersVC(viewModel: vm)
        vm.router = UsersRouter(vc: vc)
        return vc
    }
    
}
