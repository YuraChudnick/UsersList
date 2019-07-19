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
        
        
    }
    
    func constructHierarchy() {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userLogo.layer.cornerRadius = 20
        userLogo.clipsToBounds = true
    }

}
