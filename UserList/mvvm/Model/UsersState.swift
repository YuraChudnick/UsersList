//
//  State.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/23/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

enum Action {
    case add(viewModel: UserViewModel)
    case remove(UUID)
    case select(UUID?)
}

struct UsersState {
    var order: [UUID] = []
    var viewModels: [UUID: UserViewModel] = [:]
    var selected: UUID?
    
    init(with viewModels: [UserViewModel]) {
        for viewModel in viewModels {
            let id = UUID()
            order.append(id)
            self.viewModels[id] = viewModel
        }
    }
}

func update(state: UsersState, action: Action) -> UsersState {
    var result = state
    switch action {
    case .add(let viewModel):
        let id = UUID()
        result.order.append(id)
        result.viewModels[id] = viewModel
    case let .remove(id):
        result.order = state.order.filter { $0 != id }
        result.viewModels.removeValue(forKey: id)
        if state.selected == id {
            result.selected = nil
        }
    case let .select(id):
        result.selected = id
    }
    return result
}

extension ObservableType where Element == UsersState {
    
    func user(for id: UUID) -> Observable<UserViewModel?> {
        return map({ $0.viewModels[id] })
    }
    
}
