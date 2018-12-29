//
//  UsersPresenter.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Foundation

class UsersPresenter: UsersPresenterProtocol {
    
    private unowned let view: UsersViewProtocol
    private let model: UsersModelProtocol
    
    required init(view: UsersViewProtocol, model: UsersModelProtocol) {
        self.view = view
        self.model = model
    }
    
    func didRefreshUsersList() {
        model.getData { [weak self] (success, error) in
            guard let `self` = self else { return }
            switch success {
            case true:
                self.view.setUsersList(list: self.model.usersList)
            case false:
                print(error?.localizedDescription ?? "some error")
            }
            self.view.stopRefreshing()
            self.view.showHideNoDataLabel(show: self.model.usersList.isEmpty)
        }
    }
    
}
