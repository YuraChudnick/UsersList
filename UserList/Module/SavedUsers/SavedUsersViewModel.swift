//
//  SavedUsersViewModel.swift
//  UserList
//
//  Created by yura on 6/15/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation

class SavedUsersViewModel: SavedUsersViewModelProtocol {

    let model: SavedUsersModelProtocol
    
    private var users: [User] = []
    private var cellViewModels: [UserCellViewModel] = [] {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var isNoData: Bool = false {
        didSet {
            self.updateDataLabel?()
        }
    }
    var numberOfCells: Int {
        return cellViewModels.count
    }
    var selectedUser: User?
    
    var reloadTableViewClosure: (() -> Void)?
    var updateDataLabel: (() -> Void)?
    
    required init(model: SavedUsersModelProtocol = SavedUsersModel()) {
        self.model = model
    }
    
    func getUserCellViewModel(at indexPath: IndexPath) -> UserCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createUserCellViewModel(user: User) -> UserCellViewModel {
        var name = ""
        if let n = user.name {
            name = n.first.capitalizingFirstLetter() + " " + n.last.capitalizingFirstLetter()
        }
        
        return UserCellViewModel(name: name,
                                 phome: user.phone,
                                 imageUrl: URL(string: user.picture?.large ?? ""))
    }
    
    func userPressed(at indexPath: IndexPath) {
        selectedUser = users[indexPath.row]
    }
    
    func fetchUsers() {
        users = model.getUsers()
        var vm: [UserCellViewModel] = []
        users.forEach { vm.append(createUserCellViewModel(user: $0)) }
        cellViewModels = vm
    }
    
}
