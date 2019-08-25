//
//  UsersModuleBuilder.swift
//  UserList
//
//  Created by yura on 8/25/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

struct UsersModuleBuilder {
    
    func create() -> UIViewController {
        let vm = UsersViewModel(usersRepository: UsersRepository(networkTask: NetworkTask()))
        let vc = UsersVC(viewModel: vm)
        vm.router = UsersRouter(vc: vc)
        return vc
    }
    
}
