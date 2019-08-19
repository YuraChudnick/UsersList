//
//  NewEditUserModuleBuilder.swift
//  UserList
//
//  Created by yura on 8/17/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

class NewEditUserModuleBuilder {
    
    func create(with user: User) -> UIViewController {
        let vm = EditUserProfileViewModel(user: user, repository: EditUserRepository(), imageManager: ImageCacheManager())
        let vc = RxEditUserProfileVC(viewModel: vm)
        let router = EditUserRouter(vc: vc)
        vm.router = router
        return vc
    }
    
}
