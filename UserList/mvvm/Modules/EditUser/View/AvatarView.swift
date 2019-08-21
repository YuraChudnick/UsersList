//
//  AvatarView.swift
//  UserList
//
//  Created by yura on 7/25/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AvatarView: NiblessView {
    
    let imageView = UIImageView()
    
    let changeButton: UIButton = {
        let b = UIButton()
        b.setTitle("Change photo", for: .normal)
        b.setTitleColor(b.tintColor, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        b.addTarget(self, action: #selector(pressedChangeAvatar(_:)), for: .touchUpInside)
        return b
    }()
    
    let viewModel: EditUserProfileViewModelProtocol
    var hierarchyNotReady = true
    let disposeBag = DisposeBag()
    
    init(frame: CGRect = .zero, viewModel: EditUserProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else {
            return
        }
        hierarchyNotReady = false
        backgroundColor = .clear
        setupConstaints()
        setupImageView()
        bindViews()
    }
    
    fileprivate func setupConstaints() {
        addSubview(imageView)
        imageView.anchor(top: topAnchor,
                         leading: nil,
                         bottom: nil,
                         trailing: nil,
                         centerX: centerXAnchor,
                         padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0),
                         size: CGSize(width: 85, height: 85))
        addSubview(changeButton)
        changeButton.anchor(top: imageView.bottomAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: nil,
                            centerX: imageView.centerXAnchor)
    }
    
    fileprivate func setupImageView() {
        imageView.setNeedsLayout()
        imageView.layoutIfNeeded()
        imageView.layer.cornerRadius = imageView.bounds.width/2
        imageView.layer.masksToBounds = true
    }
    
    fileprivate func bindViews() {
        viewModel.avatar
            .asObservable()
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
    
    @objc private func pressedChangeAvatar(_ sender: UIButton) {
        viewModel.pressedChangeAvatar()
    }
    
}
