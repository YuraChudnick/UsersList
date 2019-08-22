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

protocol SavedUsersViewModelProtocol: UsersViewModelProtocol {
    
}

class SavedUsersViewModel: SavedUsersViewModelProtocol, UserCellViewModelCreating {

    let repository: SavedUsersRepositoryProtocol
    let disposeBag = DisposeBag()
    
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
                self?.userList.accept(viewModels)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    func selectUser(at indexPath: IndexPath) {
        
    }
    
}
