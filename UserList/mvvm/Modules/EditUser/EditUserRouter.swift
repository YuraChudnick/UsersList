//
//  EditUserRouter.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/19/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

protocol EditUserRouterProtocol {
    func presentPhotoPicker()
    func back()
}

class EditUserRouter: EditUserRouterProtocol {

    unowned let vc: EditUserVC
    
    init(vc: EditUserVC) {
        self.vc = vc
    }
    
    func presentPhotoPicker() {
        
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: UIAlertAction.Style.cancel,
                                      handler: nil))
        
        alert.addAction(UIAlertAction(title: "Photo Library",
                                      style: UIAlertAction.Style.default,
                                      handler: { _ in
                                        self.vc.photoPickerManager.presentPhotoPicker(sourceType: .photoLibrary, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Camera",
                                      style: UIAlertAction.Style.default,
                                      handler: { _ in
                                        self.vc.photoPickerManager.presentPhotoPicker(sourceType: .camera, animated: true)
        }))
        vc.present(alert, animated: true)
    }
    
    func back() {
        vc.navigationController?.popViewController(animated: true)
    }
    
}
