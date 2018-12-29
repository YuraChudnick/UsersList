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
    
}
