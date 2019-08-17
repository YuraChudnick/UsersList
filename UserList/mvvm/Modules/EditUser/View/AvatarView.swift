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
        return b
    }()                                                                 
    
}
