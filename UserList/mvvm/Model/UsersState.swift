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
    case remove(viewModel: UserViewModel)
    case select(viewModel: UserViewModel)
}

struct UsersState {
    var viewModels: [UserViewModel] = []
    var selected: UserViewModel?
}

func update(state: UsersState, action: Action) -> UsersState {
    var result = state
    switch action {
    case .add(let viewModel):
        result.viewModels.append(viewModel)
    case let .remove(viewModel):
        result.viewModels = state.viewModels.filter { $0.differenceIdentifier != viewModel.differenceIdentifier }
        if state.selected?.differenceIdentifier == viewModel.differenceIdentifier {
            result.selected = nil
        }
    case let .select(viewModel):
        result.selected = viewModel
    }
    return result
}
