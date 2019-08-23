//
//  UserCell.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var userLogo: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    
    var userCellViewModel: UserViewModel? {
        didSet {
//            userName.text = userCellViewModel?.name
//            userPhone.text = userCellViewModel?.phome
//            userLogo.kf.setImage(with: userCellViewModel?.imageUrl)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        userLogo.layer.cornerRadius = 20
        userLogo.clipsToBounds = true
    }
    
    func initCell2(user: UserEntity) {
        
        userName.text = user.first_name + " " + user.last_name.capitalizingFirstLetter()
        userPhone.text = user.phone
        userLogo.image = user.image
        
    }
    
}
