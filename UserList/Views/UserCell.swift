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

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        userLogo.layer.cornerRadius = 20
        userLogo.clipsToBounds = true
    }
    
    func initCell(user: User) {
        
        if let name = user.name {
            userName.text = name.first.capitalizingFirstLetter() + " " + name.last.capitalizingFirstLetter()
        }
        
        userPhone.text = user.phone
        
        if let picture = user.picture {
            userLogo.kf.setImage(with: URL(string: picture.large))
        }
    }
    
    func initCell2(user: UserEntity) {
        
        userName.text = user.first_name + " " + user.last_name.capitalizingFirstLetter()
        userPhone.text = user.phone
        userLogo.image = user.image
        
    }
    
}
