//
//  EditUserProfilePresenterProtocol.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Foundation

protocol EditUserProfilePresenterProtocol: class {
    
    init(view: EditUserProfileViewProtocol, model: EditUserProfileModelProtocol)
    
    func showUserInfo()
    func updateFirstName(first: String)
    func updateLastName(last: String)
    func updateEmail(email: String)
    func updatePhone(phone: String)
    func updatePhoto(photo: NSData?)
    func didPressSaveItem()
    
}
