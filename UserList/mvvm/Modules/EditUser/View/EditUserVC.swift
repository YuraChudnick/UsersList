//
//  RxEditUserProfileVC.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/16/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

class EditUserVC: NiblessViewController {
    
    lazy var photoPickerManager: PhotoPickerManager = {
        let manager = PhotoPickerManager(presentingViewController: self)
        manager.delegate = self
        return manager
    }()
    
    let viewModel: EditUserProfileViewModelProtocol
    
    init(viewModel: EditUserProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        view = EditUserRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit profile"
        setupSaveButton()
        viewModel.loadAvatar()
    }
    
    fileprivate func setupSaveButton() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(pressedSave(_:)))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func pressedSave(_ sender: UIBarButtonItem) {
        viewModel.pressedSave()
    }
    
}

extension EditUserVC: PhotoPickerManagerDelegate {
    
    func manager(_ manager: PhotoPickerManager, didPickImage image: UIImage) {
        viewModel.avatar.accept(image)
        manager.dismissPhotoPicker(animated: true, completion:
            nil)
    }
    
}
