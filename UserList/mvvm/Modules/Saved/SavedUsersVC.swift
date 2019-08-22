//
//  SavedUsersVC.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/22/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

class SavedUsersVC: NiblessViewController {
    
    let viewModel: SavedUsersViewModelProtocol
    
    init(viewModel: SavedUsersViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        view = SavedUsersRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
