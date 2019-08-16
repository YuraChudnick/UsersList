//
//  UserParameterTableViewCell.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/16/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

class UserParameterTableViewCell: NiblessTableViewCell {
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.textAlignment = .left
        l.textColor = .black
        return l
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        tf.textColor = .darkGray
        tf.textAlignment = .right
        return tf
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: contentView.topAnchor,
                          leading: contentView.leadingAnchor,
                          bottom: contentView.bottomAnchor,
                          trailing: nil,
                          padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .horizontal)
        
        contentView.addSubview(textField)
        textField.anchor(top: nil,
                         leading: titleLabel.trailingAnchor,
                         bottom: nil,
                         trailing: contentView.trailingAnchor,
                         centerY: contentView.centerYAnchor,
                         padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 16))
        
    }
    
}
