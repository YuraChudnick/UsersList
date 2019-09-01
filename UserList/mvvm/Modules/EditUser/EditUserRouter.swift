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

class EditUserRouter<V: UIViewController & PhotoPickerManagerDelegate>: EditUserRouterProtocol {

    unowned let vc: V
    
    lazy var photoPickerManager: PhotoPickerManager = {
        let manager = PhotoPickerManager(presentingViewController: vc)
        manager.delegate = vc
        return manager
    }()
    
    init(vc: V) {
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
                                        self.presentPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: "Camera",
                                      style: UIAlertAction.Style.default,
                                      handler: { _ in
                                        self.photoPickerManager.presentPhotoPicker(sourceType: .camera, animated: true)
        }))
        vc.present(alert, animated: true)
    }
    
    func back() {
        vc.navigationController?.popViewController(animated: true)
    }
    
    func presentPhotoLibrary() {
        photoPickerManager.presentPhotoPicker(sourceType: .photoLibrary, animated: true)
    }
    
}
