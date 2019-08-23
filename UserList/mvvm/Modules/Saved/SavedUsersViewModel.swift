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
    var userList = BehaviorRelay<[UserCellViewModel]>(value: [])
    var usersStore: UsersStore
    
    let savedUsersResults: Results<User>
    
    init(savedUsersRepository: SavedUsersRepositoryProtocol) {
        repository = savedUsersRepository
        savedUsersResults = savedUsersRepository.getSavedUsers()
        let userViewModels: [UserCellViewModel] = savedUsersResults.compactMap({ UserCellViewModel(user: $0) })
        usersStore = UsersStore(initialState: UsersState(with: userViewModels), reducer: update)
        setup()
    }
    
    fileprivate func setup() {
        Observable.changeset(from: savedUsersResults)
            .map({ (results, changes) -> ([UserCellViewModel], RealmChangeset?) in
                return (results.compactMap({ UserCellViewModel(user: $0) }), changes)
            })
            .subscribe(onNext: { [weak self] (viewModels, changes) in
                if let changes = changes {
                }
                self?.isNoData.accept(viewModels.isEmpty)
                //self?.userList.accept(viewModels)
            }, onError: { error in
                print(error.localizedDescription)
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
