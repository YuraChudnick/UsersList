//
//  State.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/23/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RxSwift
import RxRelay
import DifferenceKit

enum Action {
    case add(viewModel: UserViewModel)
    case remove(viewModel: UserViewModel)
    case select(viewModel: UserViewModel)
    case realmUpdates(viewModels: [UserViewModel], deleted: [Int], added: [Int], updated: [Int])
}

typealias UsersStore = Store<UsersState, Action>

extension UUID: Differentiable { }

struct UsersState {
    var viewModels: [UserViewModel]
    var selected: PublishRelay<UserViewModel> = PublishRelay()
    var removed: PublishRelay<UserViewModel> = PublishRelay()
    
    init(viewModels: [UserViewModel]) {
       self.viewModels = viewModels
    }
    
}

func update(state: UsersState, action: Action) -> UsersState {
    var result = state
    switch action {
    case .add(let viewModel):
        result.viewModels.append(viewModel)
    case let .remove(viewModel):
        result.viewModels = state.viewModels.filter { $0.differenceIdentifier != viewModel.differenceIdentifier }
        result.removed.accept(viewModel)
    case let .select(viewModel):
        result.selected.accept(viewModel)
    case let .realmUpdates(viewModels, deleted, added, updated):
        print("Saved users added: \(added)")
        print("Saved users deleted: \(deleted)")
        print("Saved users updated: \(updated)")
        if deleted.isEmpty {
            added.forEach({ result.viewModels.append(viewModels[$0]) })
        }
        updated.forEach({
            result.viewModels[optional: $0]?.update()
        })
    }
    return result
}
