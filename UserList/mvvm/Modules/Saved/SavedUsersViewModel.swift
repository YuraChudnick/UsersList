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
    func deleteUser(at indexPath: IndexPath)
}

class SavedUsersViewModel: SavedUsersViewModelProtocol, UserCellViewModelCreating {

    let repository: SavedUsersRepositoryProtocol
    var router: UsersRouterProtocol!
    let disposeBag = DisposeBag()
    
    var isNoData: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    var userList = BehaviorRelay<[UserCellViewModel]>(value: [])
    let savedUsersResults: Results<User>
    
    init(savedUsersRepository: SavedUsersRepositoryProtocol) {
        repository = savedUsersRepository
        savedUsersResults = savedUsersRepository.getSavedUsers()
        setup()
    }
    
    fileprivate func setup() {
        Observable.changeset(from: savedUsersResults)
            .map({ [weak self] (results, changes) -> ([UserCellViewModel], RealmChangeset?) in
                return (results.compactMap({ self?.createUserCellViewModel(user: $0) }), changes)
            })
            .subscribe(onNext: { [weak self] (viewModels, _) in
                self?.isNoData.accept(viewModels.isEmpty)
                self?.userList.accept(viewModels)
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
