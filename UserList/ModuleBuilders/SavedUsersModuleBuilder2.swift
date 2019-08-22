//
//  SavedUsersModuleBuilder.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit

class SavedUsersModuleBuilder2: ModuleBuilderProtocol {
    
    func create() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SavedUsersVC")
        return vc
    }
    
}
