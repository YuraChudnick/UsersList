//
//  ItemView.swift
//  UserList
//
//  Created by yura on 7/25/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ItemView: NiblessView {

    let viewModel: ItemViewModel
    var hierarchyNotReady = true
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 17)
        l.textColor = .black
        return l
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.textColor = .darkGray
        tf.textAlignment = .right
        return tf
    }()
    
    init(frame: CGRect = .zero, viewModel: ItemViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else {
            return
        }
        backgroundColor = .white
        setupViews()
    }
    
    fileprivate func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, textField])
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
    }
    
}
