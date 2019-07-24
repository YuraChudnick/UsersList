//
//  NewUserTableViewCell.swift
//  UserList
//
//  Created by Yurii Chudnovets on 7/19/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

class NewUserTableViewCell: NiblessTableViewCell {

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
    
    var userCellViewModel: UserCellViewModel? {
        didSet {
            userName.text = userCellViewModel?.name
            userPhone.text = userCellViewModel?.phome
            userLogo.kf.setImage(with: userCellViewModel?.imageUrl)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        contentView.addSubview(userLogo)
        userLogo.anchor(top: nil,
                        leading: contentView.leadingAnchor,
                        bottom: nil,
                        trailing: nil,
                        centerY: contentView.centerYAnchor,
                        padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0),
                        size: CGSize(width: 40, height: 40))
        
        let stackView = UIStackView(arrangedSubviews: [userName, userLogo])
        stackView.axis = .vertical
        
        contentView.addSubview(stackView)
        stackView.anchor(top: contentView.topAnchor,
                         leading: userLogo.trailingAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.trailingAnchor,
                         padding: UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8))
        
        accessoryType = .disclosureIndicator
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userLogo.layer.cornerRadius = 20
        userLogo.clipsToBounds = true
    }

}
