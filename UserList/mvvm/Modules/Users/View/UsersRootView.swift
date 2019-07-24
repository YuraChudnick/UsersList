//
//  UsersRootView.swift
//  UserList_iOS
//
//  Created by Yurii Chudnovets on 7/15/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UsersRootView: NiblessView {
    
    //MARK: - Properties
    let viewModel: RxUsersViewModel
    let disposeBag = DisposeBag()
    var hierarchyNotReady = true
    
    let tableView = UITableView()
    
    init(frame: CGRect = .zero, viewModel: RxUsersViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else {
            return
        }
        backgroundColor = .white
        constructHierarchy()
        activateConstraints()
        setupTableView()
        hierarchyNotReady = false
        bindViews()
    }
    
    func constructHierarchy() {
        addSubview(tableView)
    }
    
    func activateConstraints() {
        tableView.fillSuperview()
    }
    
    func setupTableView() {
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
        tableView.rx.willDisplayCell.subscribe(onNext: { (_ , indexPath) in
            self.viewModel.willDisplayUser(at: indexPath)
        }).disposed(by: disposeBag)
    }
    
}


