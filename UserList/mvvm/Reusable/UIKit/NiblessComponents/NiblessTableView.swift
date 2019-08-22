//
//  NiblessTableView.swift
//  UserList
//
//  Created by Yurii Chudnovets on 7/25/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

class NiblessTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    @available(*, unavailable,
    message: "Loading this view from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
    
}
