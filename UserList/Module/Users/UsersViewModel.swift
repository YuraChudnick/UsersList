//
//  UsersViewModel.swift
//  UserList
//
//  Created by Yurii Chudnovets on 6/14/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation

class UsersViewModel: UsersViewModelProtocolOld {
    
    let model: UsersModelProtocol
    
    private var users: [User] = []
    private var page: Int = 0
    
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
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var selectedUser: User?
    
    var reloadTableViewClosure: (() -> Void)?
    var updateDataLabel: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    
    required init(model: UsersModelProtocol = UsersModel()) {
        self.model = model
    }
    
    func reloadData() {
        self.isLoading = true
        model.getUsers(page: page) { [weak self] response in
            self?.isLoading = false
            switch response {
            case .data(let data):
                self?.processFetched(users: data.results)
            case .error(_ , let error):
                self?.processFetched(users: [])
                print(error ?? "fetching users error")
            }
        }
    }
    
    func getUserCellViewModel(at indexPath: IndexPath) -> UserCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    private func processFetched(users: [User]) {
        self.users += users
        var vm: [UserCellViewModel] = []
        self.users.forEach { vm.append(UserCellViewModel(user: $0)) }
        cellViewModels = vm
        isNoData = cellViewModels.isEmpty
    }
    
    func userPressed(at indexPath: IndexPath) {
        selectedUser = users[indexPath.row]
    }
    
}
