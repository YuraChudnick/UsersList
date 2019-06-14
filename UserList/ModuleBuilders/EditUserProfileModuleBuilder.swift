//
//  EditUserProfileModuleBuilder.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit

class EditUserProfileModuleBuilder: ModuleBuilderProtocol {
    
    func create(with data: Any) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditUserProfileVC") as! EditUserProfileVC
        vc.presenter = EditUserProfilePresenter(view: vc, model: EditUserProfileModel(userData: data as? User))
        return vc
    }
    
}
