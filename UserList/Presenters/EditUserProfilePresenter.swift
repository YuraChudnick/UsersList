//
//  EditUserProfilePresenter.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Foundation

class EditUserProfilePresenter: EditUserProfilePresenterProtocol {

    private unowned let view: EditUserProfileViewProtocol
    private let model: EditUserProfileModelProtocol
    
    required init(view: EditUserProfileViewProtocol, model: EditUserProfileModelProtocol) {
        self.view = view
        self.model = model
    }
    
    func showUserInfo() {
        view.setUserInfo(info: model.userData)
    }
    
    func updateFirstName(first: String) {
        model.userData?.setFirstName(first: first)
    }
    
    func updateLastName(last: String) {
        model.userData?.setLastName(last: last)
    }
    
    func updateEmail(email: String) {
        model.userData?.setEmail(email: email)
    }
    
    func updatePhone(phone: String) {
        model.userData?.setPhone(phone: phone)
    }
    
    func updatePhoto(photo: NSData?) {
        model.userData?.setImage(data: photo)
    }
    
    func didPressSaveItem() {
        model.saveItem()
    }
    
}
