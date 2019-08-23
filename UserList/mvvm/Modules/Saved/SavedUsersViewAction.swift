//
//  SavedUserAction.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/23/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType where Element == Void {
    func add(viewModel: UserCellViewModel) -> Observable<Action> {
        return map { Action.add(viewModel: viewModel) }
    }
}

extension ObservableType where Element == IndexPath {
    func select(state: Observable<UsersState>) -> Observable<Action> {
        return withLatestFrom(state.map { $0.order }) { $1[$0.row] }
            .map { Action.select($0) }
    }
    
    func delete(state: Observable<UsersState>) -> Observable<Action> {
        return withLatestFrom(state.map { $0.order }) { $1[$0.row] }
            .map { Action.remove($0) }
    }
}
