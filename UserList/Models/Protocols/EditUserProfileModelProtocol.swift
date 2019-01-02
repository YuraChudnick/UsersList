//
//  EditUserProfileModel.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Foundation

protocol EditUserProfileModelProtocol: class {
    
    var userData: UserProtocol? { get set }
    
    init(userData: UserProtocol?)
    
    func saveItem()
    
}
