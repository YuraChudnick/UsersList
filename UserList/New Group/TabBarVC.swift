//
//  TabBarVC.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tabBarControllers: [UIViewController] = []
        
        let vm = UsersViewModel(usersRepository: UsersRepository(networkTask: NetworkTask()))
        let usersModule = UsersVC(viewModel: vm)
        vm.router = UsersRouter(vc: usersModule)
        usersModule.tabBarItem = UITabBarItem(title: "Users", image: UIImage(named: "tab_users"), tag: 0)
        tabBarControllers.append(UINavigationController(rootViewController: usersModule))
        
        let savedUsersModule = SavedUsersModuleBuilder().create()
        savedUsersModule.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(named: "tab_saved"), tag: 1)
        tabBarControllers.append(UINavigationController(rootViewController: savedUsersModule))
        
        viewControllers = tabBarControllers
    }

}
