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
import RxRelay

enum Action {
    case add(viewModel: UserViewModel)
    case remove(viewModel: UserViewModel)
    case select(viewModel: UserViewModel)
}

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
    }
    return result
}
