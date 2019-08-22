//
//  SavedUsersRootView.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/22/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SavedUsersRootView: NiblessView {
    
    //MARK: - Properties
    let viewModel: SavedUsersViewModelProtocol
    let disposeBag = DisposeBag()
    var hierarchyNotReady = true
    
    let tableView = UITableView()
    
    init(frame: CGRect = .zero, viewModel: SavedUsersViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else {
            return
        }
        backgroundColor = .white
        setupTableView()
        hierarchyNotReady = false
        bindViews()
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.fillSuperview()
        
        tableView.separatorInset = .zero
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(NewUserTableViewCell.self, forCellReuseIdentifier: NewUserTableViewCell.className)
    }
    
    func bindViews() {
        viewModel.userList
            .bind(to: tableView.rx.items(cellIdentifier: NewUserTableViewCell.className, cellType: NewUserTableViewCell.self))
            { (row, element, cell) in
                cell.userCellViewModel = element
            }
            .disposed(by: disposeBag)
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.viewModel.selectUser(at: indexPath)
            })
            .disposed(by: disposeBag)
    }
    
}
