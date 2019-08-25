//
//  NewUsersVC.swift
//  UserList
//
//  Created by Yurii Chudnovets on 7/24/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

class UsersVC: NiblessViewController, DeselectAnimatable {
    
    let viewModel: UsersViewModelProtocol
    
    init(viewModel: UsersViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        view = UsersRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Users"
        viewModel.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        deselectRow(in: (view as! UsersRootView).tableView, animated: animated)
    }
    
}
