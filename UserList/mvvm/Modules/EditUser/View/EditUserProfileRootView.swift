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

class EditUserProfileRootView: NiblessView {
    
    //MARK: - Properties
    let viewModel: EditUserProfileViewModelProtocol
    let disposeBag = DisposeBag()
    var hierarchyNotReady = true
    
    let tableView = UITableView()
    //lazy var avatarView = AvatarView(viewModel: self.viewModel)
    
    init(frame: CGRect = .zero, viewModel: EditUserProfileViewModelProtocol) {
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
//        addSubview(avatarView)
//        avatarView.anchor(top: safeAreaLayoutGuide.topAnchor,
//                         leading: leadingAnchor,
//                         bottom: nil,
//                         trailing: trailingAnchor,
//                         size: CGSize(width: 0, height: 210))
        
        addSubview(tableView)
        tableView.fillSuperview()
        tableView.backgroundColor = .clear
//        tableView.anchor(top: avatarView.bottomAnchor,
//                         leading: leadingAnchor,
//                         bottom: bottomAnchor,
//                         trailing: trailingAnchor)
        tableView.separatorInset = .zero
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UserParameterTableViewCell.self, forCellReuseIdentifier: UserParameterTableViewCell.className)
        tableView.register(UserAvatarTableViewCell.self, forCellReuseIdentifier: UserAvatarTableViewCell.className)
    }
    
    fileprivate func bindViews() {
//        viewModel.userParameterViewModels
//            .bind(to: tableView.rx.items(cellIdentifier: UserParameterTableViewCell.className, cellType: UserParameterTableViewCell.self)) { (row, element, cell) in
//                cell.viewModel = element
//            }
//            .disposed(by: disposeBag)
        viewModel.userParameterViewModels
            .bind(to: tableView.rx.items) { [weak self] (table, index, element) -> UITableViewCell in
                switch (element) {
                case .avatar:
                    let cell = table.dequeueReusableCell(withIdentifier: UserAvatarTableViewCell.className, for: IndexPath(row: index, section: 0)) as! UserAvatarTableViewCell
                    cell.viewModel = self?.viewModel
                    return cell
                case .parameter(let viewModel):
                    let cell = table.dequeueReusableCell(withIdentifier: UserParameterTableViewCell.className, for: IndexPath(row: index, section: 0)) as! UserParameterTableViewCell
                    cell.viewModel = viewModel
                    return cell
                }
            }
            .disposed(by: disposeBag)
    }
    
}
