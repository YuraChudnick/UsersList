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
    let viewModel: UsersViewModelProtocol
    let disposeBag = DisposeBag()
    var hierarchyNotReady = true
    
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    let noDataLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 15)
        l.textAlignment = .center
        l.text = "No users. Pull down to refresh."
        l.isHidden = true
        return l
    }()
    
    init(frame: CGRect = .zero, viewModel: UsersViewModelProtocol) {
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
        tableView.anchor(top: safeAreaLayoutGuide.topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor)
        
        tableView.backgroundView = noDataLabel
        tableView.refreshControl = refreshControl
        tableView.separatorInset = .zero
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.className)
    }
    
    func bindViews() {
        let viewModel = self.viewModel
        viewModel.userList
            .bind(to: tableView.rx.items(cellIdentifier: UserTableViewCell.className, cellType: UserTableViewCell.self))
            { (row, viewModel, cell) in
                cell.configure(with: viewModel)
            }
            .disposed(by: disposeBag)
        viewModel.userList
            .skip(1)
            .map({ !$0.isEmpty })
            .bind(to: noDataLabel.rx.isHidden)
            .disposed(by: disposeBag)
       
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.viewModel.selectUser(at: indexPath)
            })
            .disposed(by: disposeBag)
    
        tableView.rx.willDisplayCell
            .subscribe(onNext: { (_ , indexPath) in
            self.viewModel.willDisplayUser(at: indexPath)
            })
            .disposed(by: disposeBag)
        
        viewModel.isRefreshing
            .delay(RxTimeInterval.milliseconds(300), scheduler: MainScheduler())
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        viewModel.isRefreshing
            .skip(1)
            .filter({ value -> Bool in
                return value
            })
            .bind(to: noDataLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        refreshControl.rx
            .controlEvent(.valueChanged)
            .bind(to: viewModel.loadTrigger)
            .disposed(by: disposeBag)
        
    }
    
}


