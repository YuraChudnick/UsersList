//
//  EditUserProfileView.swift
//  UserList
//
//  Created by yura on 7/25/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EditUserRootView: NiblessView {
    
    //MARK: - Properties
    let viewModel: EditUserViewModelProtocol
    let disposeBag = DisposeBag()
    var hierarchyNotReady = true
    
    let tableView = UITableView()
    
    init(frame: CGRect = .zero, viewModel: EditUserViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else {
            return
        }
        backgroundColor = .groupTableViewBackground
        setupViews()
        hierarchyNotReady = false
        bindViews()
    }
    
    fileprivate func setupViews() {
        addSubview(tableView)
        tableView.fillSuperview()
        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        tableView.estimatedRowHeight = 202
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UserParameterTableViewCell.self, forCellReuseIdentifier: UserParameterTableViewCell.className)
        tableView.register(UserAvatarTableViewCell.self, forCellReuseIdentifier: UserAvatarTableViewCell.className)
    }
    
    fileprivate func bindViews() {
        viewModel.userParameterViewModels
            .bind(to: tableView.rx.items) { [weak self] (table, index, element) -> UITableViewCell in
                switch (element) {
                case .avatar:
                    let cell = table.dequeueReusableCell(withIdentifier: UserAvatarTableViewCell.className, for: IndexPath(row: index, section: 0)) as! UserAvatarTableViewCell
                    cell.configure(with: self?.viewModel)
                    return cell
                case .parameter(let viewModel):
                    let cell = table.dequeueReusableCell(withIdentifier: UserParameterTableViewCell.className, for: IndexPath(row: index, section: 0)) as! UserParameterTableViewCell
                    cell.configure(with: viewModel)
                    return cell
                }
            }
            .disposed(by: disposeBag)
    }
    
}
