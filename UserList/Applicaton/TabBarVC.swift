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
        
        var viewControllers: [UIViewController] = []
        
        let usersVC = UsersModuleBuilder().create()
        usersVC.tabBarItem = UITabBarItem(title: "Users", image: UIImage(named: "tab_users"), tag: 0)
        viewControllers.append(UINavigationController(rootViewController: usersVC))
        
        let savedUsersVC = SavedUsersModuleBuilder().create()
        savedUsersVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(named: "tab_saved"), tag: 1)
        viewControllers.append(UINavigationController(rootViewController: savedUsersVC))
        
        self.viewControllers = viewControllers
    }

}
