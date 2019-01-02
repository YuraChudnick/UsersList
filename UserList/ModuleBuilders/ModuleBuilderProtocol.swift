//
//  ModuleBuilderProtocol.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit

@objc protocol ModuleBuilderProtocol: class {
    
    @objc optional func create() -> UIViewController
    
    @objc optional func create(with data: Any) -> UIViewController
    
}
