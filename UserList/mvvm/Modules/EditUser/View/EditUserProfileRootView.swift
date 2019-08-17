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
    let avatarView = AvatarView()
    
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
        addSubview(avatarView)
        avatarView.anchor(top: safeAreaLayoutGuide.topAnchor,
                         leading: leadingAnchor,
                         bottom: nil,
                         trailing: trailingAnchor,
                         size: CGSize(width: 0, height: 210))
        
        addSubview(tableView)
        tableView.anchor(top: avatarView.bottomAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor)
        tableView.separatorInset = .zero
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UserParameterTableViewCell.self, forCellReuseIdentifier: UserParameterTableViewCell.className)
    }
    
    fileprivate func bindViews() {
        
    }
    
}
