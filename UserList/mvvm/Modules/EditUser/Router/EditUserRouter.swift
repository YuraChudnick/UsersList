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
}

class EditUserRouter: EditUserRouterProtocol {

    unowned let vc: RxEditUserProfileVC
    
    init(vc: RxEditUserProfileVC) {
        self.vc = vc
    }
    
    func presentPhotoPicker() {
        let photoPickerManager = PhotoPickerManager(presentingViewController: vc)
        photoPickerManager.delegate = vc
        
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: UIAlertActionStyle.cancel,
                                      handler: nil))
        
        alert.addAction(UIAlertAction(title: "Photo Library",
                                      style: UIAlertActionStyle.default,
                                      handler: { _ in
                                        photoPickerManager.presentPhotoPicker(sourceType: .photoLibrary, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Camera",
                                      style: UIAlertActionStyle.default,
                                      handler: { _ in
                                        photoPickerManager.presentPhotoPicker(sourceType: .camera, animated: true)
        }))
        vc.present(alert, animated: true)
    }
    
}
