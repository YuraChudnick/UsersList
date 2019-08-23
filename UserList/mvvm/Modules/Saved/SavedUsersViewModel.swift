//
//  SavedUsersViewModel.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/22/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RxSwift
import RxRelay
import RealmSwift
import RxRealm

protocol SavedUsersViewModelProtocol: UsersViewModelProtocol, NoDataProtocol {
    var usersStore: UsersStore { get }
    func deleteUser(at indexPath: IndexPath)
}

class SavedUsersViewModel: SavedUsersViewModelProtocol {
    
    let repository: SavedUsersRepositoryProtocol
    var router: UsersRouterProtocol!
    let disposeBag = DisposeBag()
    
    var isNoData: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    var userList = BehaviorRelay<[UserViewModel]>(value: [])
    var usersStore: UsersStore
    let userState: UsersState
    
    let savedUsersResults: Results<User>
    
    init(savedUsersRepository: SavedUsersRepositoryProtocol) {
        repository = savedUsersRepository
        savedUsersResults = savedUsersRepository.getSavedUsers()
        let userViewModels: [UserViewModel] = savedUsersResults.compactMap({ UserViewModel(user: $0) })
        userState = UsersState(viewModels: userViewModels)
        usersStore = UsersStore(initialState: userState, reducer: update)
        subcribeToReakmUpdates()
        bindActions()
    }
    
    fileprivate func subcribeToReakmUpdates() {
        Observable.changeset(from: savedUsersResults)
            .map({ (results, changes) -> ([UserViewModel], RealmChangeset?) in
                return (results.compactMap({ UserViewModel(user: $0) }), changes)
            })
            .subscribe(onNext: { [weak self] (viewModels, changes) in
                if let changes = changes {
                    for i in changes.updated {
                        
                    }
                }
                self?.isNoData.accept(viewModels.isEmpty)
                //self?.userList.accept(viewModels)
            }, onError: { error in
                print(error.localizedDescription)
            })
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
    
    func selectUser(at indexPath: IndexPath) {
        router.presentEditScreen(with: savedUsersResults[indexPath.row])
    }
    
    func deleteUser(at indexPath: IndexPath) {
        repository.delete(user: savedUsersResults[indexPath.row])
    }
    
}
