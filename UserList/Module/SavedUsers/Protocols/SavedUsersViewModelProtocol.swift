//
//  SavedUsersViewModelProtocol.swift
//  UserList
//
//  Created by yura on 6/15/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation

protocol SavedUsersViewModelProtocol {
    
    var isNoData: Bool { get set }
    var numberOfCells: Int { get }
    var selectedUser: User? { get }
    var reloadTableViewClosure: (() -> Void)? { get set }
    var updateDataLabel: (() -> Void)? { get set }
    
    init(model: SavedUsersModelProtocol)
    
    func getUserCellViewModel(at indexPath: IndexPath) -> UserCellViewModel
    func userPressed(at indexPath: IndexPath)
    func fetchUsers()
}
