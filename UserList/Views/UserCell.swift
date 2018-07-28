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
    
}
