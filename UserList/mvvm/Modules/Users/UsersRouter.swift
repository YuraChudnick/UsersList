//
//  NewUsersRouter.swift
//  UserList
//
//  Created by yura on 8/17/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

protocol UsersRouterProtocol {
    func presentEditScreen(with user: User)
}

class UsersRouter: UsersRouterProtocol {
    
    unowned let vc: UIViewController
    
    init(vc: UIViewController) {
        self.vc = vc
    }
    
    func presentEditScreen(with user: User) {
        let vm = EditUserViewModel(user: user, repository: UsersRepository(), imageManager: ImageCacheManager())
        let editUserVC = EditUserVC(viewModel: vm)
        let router = EditUserRouter(vc: editUserVC)
        vm.router = router
        editUserVC.hidesBottomBarWhenPushed = true
        vc.navigationController?.pushViewController(editUserVC, animated: true)
    }
    
}
