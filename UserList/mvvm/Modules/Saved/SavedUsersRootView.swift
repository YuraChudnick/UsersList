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
    
    let noDataLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 15)
        l.textAlignment = .center
        l.text = "No saved users"
        return l
    }()
    
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
        
        tableView.backgroundView = noDataLabel
        tableView.separatorInset = .zero
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(NewUserTableViewCell.self, forCellReuseIdentifier: NewUserTableViewCell.className)
    }
    
    func bindViews() {
//        viewModel.userList
//            .bind(to: tableView.rx.items(cellIdentifier: NewUserTableViewCell.className, cellType: NewUserTableViewCell.self))
//            { (row, viewModel, cell) in
//                cell.configure(with: viewModel)
//            }
//            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .select(state: viewModel.usersStore.state)
            .bind(to: viewModel.usersStore)
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .delete(state: viewModel.usersStore.state)
            .bind(to: viewModel.usersStore)
            .disposed(by: disposeBag)
        
        let _store = viewModel.usersStore
        let dataSource = RxSimpleAnimatableDataSource<UUID, NewUserTableViewCell>(identifier: NewUserTableViewCell.className) { (_, id, cell) in
            cell.configure(with: _store, id: id)
        }
        
        viewModel.usersStore
            .state
            .map({ $0.order })
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.isNoData
            .map({ !$0 })
            .bind(to: noDataLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
//        tableView.rx.itemSelected
//            .subscribe(onNext: { [weak self] indexPath in
//                self?.viewModel.selectUser(at: indexPath)
//            })
//            .disposed(by: disposeBag)
//        tableView.rx.itemDeleted
//            .subscribe(onNext: { [weak self] indexPath in
//                self?.viewModel.deleteUser(at: indexPath)
//            })
//            .disposed(by: disposeBag)
    }
    
}
