//
//  NewEditUserModuleBuilder.swift
//  UserList
//
//  Created by yura on 8/17/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

class EditUserModuleBuilder {
    
    func create(with user: User) -> UIViewController {
        let vm = EditUserProfileViewModel(user: user, repository: UsersRepository(), imageManager: ImageCacheManager())
        let vc = EditUserVC(viewModel: vm)
        let router = EditUserRouter(vc: vc)
        vm.router = router
        return vc
    }
    
}
