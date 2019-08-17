//
//  AvatarView.swift
//  UserList
//
//  Created by yura on 7/25/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

class AvatarView: NiblessView {
    
    let imageView = UIImageView()
    
    let changeButton: UIButton = {
        let b = UIButton()
        b.setTitle("Change photo", for: .normal)
        b.setTitleColor(b.tintColor, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        backgroundColor = .clear
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
    
}
