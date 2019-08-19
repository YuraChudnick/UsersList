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

class NewUsersRouter: UsersRouterProtocol {
    
    unowned let vc: UIViewController
    
    init(vc: UIViewController) {
        self.vc = vc
    }
    
    func presentEditScreen(with user: User) {
        let vm = EditUserProfileViewModel(repository: EditUserRepository())
        let editUserVC = RxEditUserProfileVC(viewModel: vm)
        let router = EditUserRouter(vc: editUserVC)
        vm.router = router
        editUserVC.hidesBottomBarWhenPushed = true
        vc.navigationController?.pushViewController(editUserVC, animated: true)
    }
    
}
