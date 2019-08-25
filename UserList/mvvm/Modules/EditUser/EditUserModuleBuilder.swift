//
//  NewEditUserModuleBuilder.swift
//  UserList
//
//  Created by yura on 8/17/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

struct EditUserModuleBuilder {
    
    func create(with user: User) -> UIViewController {
        let vm = EditUserProfileViewModel(user: user, repository: UsersRepository(), imageManager: ImageCacheManager())
        let vc = EditUserVC(viewModel: vm)
        vm.router = EditUserRouter(vc: vc)
        return vc
    }
    
}
