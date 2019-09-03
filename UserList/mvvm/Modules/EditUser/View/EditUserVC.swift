//
//  RxEditUserProfileVC.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/16/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

class EditUserVC: NiblessViewController {
    
    let viewModel: EditUserViewModelProtocol
    
    init(viewModel: EditUserViewModelProtocol) {
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
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(pressedSave))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func pressedSave() {
        viewModel.pressedSave()
    }
    
}

extension EditUserVC: PhotoPickerManagerDelegate {
    
    func manager(_ manager: PhotoPickerManager, didPickImage image: UIImage) {
        viewModel.avatar.accept(image)
    }
    
}
