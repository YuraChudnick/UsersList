//
//  UsersRouter.swift
//  UserList
//
//  Created by yura on 6/15/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

class UsersRouter: Router {
    
    func route(to routeID: String, from context: UIViewController, parameters: Any?) {
        guard let route = UsersVC.Route(rawValue: routeID) else { return }
        switch route {
        case .editUser:
            let vc = EditUserProfileModuleBuilder().create(with: parameters)
            context.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
