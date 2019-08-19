//
//  RxEditUserProfileVC.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/16/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

class RxEditUserProfileVC: NiblessViewController {
    
    let viewModel: EditUserProfileViewModelProtocol
    
    init(viewModel: EditUserProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        view = EditUserProfileRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit profile"
    }
    
}

extension RxEditUserProfileVC: PhotoPickerManagerDelegate {
    
    func manager(_ manager: PhotoPickerManager, didPickImage image: UIImage) {
        manager.dismissPhotoPicker(animated: true, completion:
            nil)
    }
    
}
