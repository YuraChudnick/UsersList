//
//  UserAvatarTableViewCell.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/19/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserAvatarTableViewCell: NiblessTableViewCell {
    
    let avatarImageView = UIImageView()
    
    let changeButton: UIButton = {
        let b = UIButton()
        b.setTitle("Change photo", for: .normal)
        b.setTitleColor(b.tintColor, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        b.addTarget(self, action: #selector(pressedChangeAvatar(_:)), for: .touchUpInside)
        return b
    }()
    
    var viewModel: EditUserProfileViewModelProtocol? {
        didSet {
            disposeBag = DisposeBag()
            viewModel?.avatar
                .asObservable()
                .bind(to: avatarImageView.rx.image)
                .disposed(by: disposeBag)
        }
    }
    
    var hierarchyNotReady = true
    var disposeBag: DisposeBag!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = nil
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else {
            return
        }
        hierarchyNotReady = false
        backgroundColor = .clear
        selectionStyle = .none
        setupConstaints()
        setupAvatarImageView()
    }
    
    fileprivate func setupConstaints() {
        addSubview(avatarImageView)
        avatarImageView.anchor(top: topAnchor,
                         leading: nil,
                         bottom: nil,
                         trailing: nil,
                         centerX: centerXAnchor,
                         padding: UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0),
                         size: CGSize(width: 85, height: 85))
        addSubview(changeButton)
        changeButton.anchor(top: avatarImageView.bottomAnchor,
                            leading: nil,
                            bottom: bottomAnchor,
                            trailing: nil,
                            centerX: avatarImageView.centerXAnchor,
                            padding: UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0))
    }
    
    fileprivate func setupAvatarImageView() {
        avatarImageView.setNeedsLayout()
        avatarImageView.layoutIfNeeded()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width/2
        avatarImageView.layer.masksToBounds = true
    }
    
    @objc private func pressedChangeAvatar(_ sender: UIButton) {
        print("Good")
        viewModel?.pressedChangeAvatar()
    }
    
    
}
