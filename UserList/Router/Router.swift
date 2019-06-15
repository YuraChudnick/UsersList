//
//  Router.swift
//  UserList
//
//  Created by yura on 6/15/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

protocol Router {
    
    func route(to routeID: String, from context: UIViewController, parameters: Any?)
    
}
