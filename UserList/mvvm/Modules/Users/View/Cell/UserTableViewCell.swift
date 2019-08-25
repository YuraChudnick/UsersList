//
//  NewUserTableViewCell.swift
//  UserList
//
//  Created by Yurii Chudnovets on 7/19/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit
import RxSwift

class UserTableViewCell: NiblessTableViewCell {

    let userLogo: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let userName: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.textColor = .black
        return l
    }()
    
    let userPhone: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .darkGray
        return l
    }()
    
    private var hierarchyNotReady = true
    private var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else {
            return
        }
        hierarchyNotReady = false
        setupConstraints()
        setupUserLogo()
        accessoryType = .disclosureIndicator
    }
    
    fileprivate func setupConstraints() {
        contentView.addSubview(userLogo)
        userLogo.anchor(top: nil,
                        leading: contentView.leadingAnchor,
                        bottom: nil,
                        trailing: nil,
                        centerY: contentView.centerYAnchor,
                        padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0),
                        size: CGSize(width: 40, height: 40))
        
        let stackView = UIStackView(arrangedSubviews: [userName, userPhone])
        stackView.axis = .vertical
        
        contentView.addSubview(stackView)
        stackView.anchor(top: contentView.topAnchor,
                         leading: userLogo.trailingAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.trailingAnchor,
                         padding: UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8))
    }
    
    fileprivate func setupUserLogo() {
        userLogo.setNeedsLayout()
        userLogo.layoutIfNeeded()
        userLogo.layer.cornerRadius = userLogo.bounds.width/2
        userLogo.layer.masksToBounds = true
    }
    
    func configure(with viewModel: UserViewModel) {
        viewModel.name
            .bind(to: userName.rx.text)
            .disposed(by: disposeBag)
        viewModel.phone
            .bind(to: userPhone.rx.text)
            .disposed(by: disposeBag)
        viewModel.imageUrl
            .subscribe(onNext: { [weak self] url in
                self?.userLogo.kf.setImage(with: url)
            })
            .disposed(by: disposeBag)
    }
    
}
