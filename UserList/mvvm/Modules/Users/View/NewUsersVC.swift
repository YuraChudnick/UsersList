//
//  NewUsersVC.swift
//  UserList
//
//  Created by Yurii Chudnovets on 7/24/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit
import RxSwift

class NewUsersVC: NiblessViewController {
    
    let viewModel: RxUsersViewModelProtocol
    
    init(viewModel: RxUsersViewModelProtocol) {
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
    
}
