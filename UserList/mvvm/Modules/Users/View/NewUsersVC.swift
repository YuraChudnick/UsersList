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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tableView = (view as! UsersRootView).tableView
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            if let coordinator = transitionCoordinator {
                coordinator.animate(alongsideTransition: { context in
                    tableView.deselectRow(at: selectedIndexPath, animated: true)
                }) { context in
                    if context.isCancelled {
                        tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
                    }
                }
            } else {
                tableView.deselectRow(at: selectedIndexPath, animated: animated)
            }
        }
        
    }
    
}
