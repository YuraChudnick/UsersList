//
//  UsersViewModelProtocol.swift
//  UserList
//
//  Created by yura on 6/15/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation

protocol UsersViewModelProtocolOld {
    
    var isNoData: Bool { get }
    var isLoading: Bool { get }
    var numberOfCells: Int { get }
    var selectedUser: User? { get }
    var reloadTableViewClosure: (() -> Void)? { get set }
    var updateDataLabel: (() -> Void)? { get set }
    var updateLoadingStatus: (() -> Void)? { get set }
    
    init(model: UsersModelProtocol)
    
    func reloadData()
    func getUserCellViewModel(at indexPath: IndexPath) -> UserViewModel
    func userPressed(at indexPath: IndexPath)
    
    
}
