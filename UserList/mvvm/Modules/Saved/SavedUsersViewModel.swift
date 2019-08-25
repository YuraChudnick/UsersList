//
//  SavedUsersViewModel.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/22/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RealmSwift
import RxSwift
import RxRealm

protocol SavedUsersViewModelProtocol {
    var usersStore: UsersStore { get }
}

class SavedUsersViewModel: SavedUsersViewModelProtocol {
    
    let repository: UsersRepositoryProtocol
    var router: UsersRouterProtocol!
    let disposeBag = DisposeBag()
    
    var usersStore: UsersStore
    let userState: UsersState
    
    let savedUsersResults: Results<User>
    
    init(repository: UsersRepositoryProtocol) {
        self.repository = repository
        savedUsersResults = repository.getSavedUsers()
        let userViewModels: [UserViewModel] = savedUsersResults.compactMap({ UserViewModel(user: $0) })
        userState = UsersState(viewModels: userViewModels)
        usersStore = UsersStore(initialState: userState, reducer: update)
        subcribeToRealmUpdates()
        bindActions()
    }
    
    fileprivate func subcribeToRealmUpdates() {
        Observable.changeset(from: savedUsersResults)
            .toUserViewModelsWithChages()
            .updateState()
            .bind(to: usersStore)
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindActions() {
        userState.selected
            .subscribe(onNext: { [weak self] viewModel in
                self?.router.presentEditScreen(with: viewModel.user)
            })
            .disposed(by: disposeBag)
        userState.removed
            .subscribe(onNext: { [weak self] viewModel in
                self?.repository.delete(user: viewModel.user)
            })
            .disposed(by: disposeBag)
    }
    
}
