//
//  UsersViewModel.swift
//  UserListKit
//
//  Created by Yurii Chudnovets on 7/19/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RxSwift
import RxRelay

class RxUsersViewModel {
    
    let usersRepository: UsersRepository
    private var users = BehaviorRelay<[User]>(value: [])
    let userList = BehaviorRelay<[UserCellViewModel]>(value: [])
    let disposeBag = DisposeBag()
    private var page = 0
    
    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
        setup()
    }
    
    fileprivate func setup() {
        users.asObservable()
            .map({ [weak self] users -> [UserCellViewModel] in
                return users.compactMap({ self?.createUserCellViewModel(user: $0) })
            })
            .subscribe(onNext: { [weak self] userCellVM in
                self?.userList.accept(userCellVM)
            }, onError: { (error) in
                print(error)
            }, onCompleted: nil)
            .disposed(by: disposeBag)
    }
    
    func selectUser(at indexPath: IndexPath) {
        print(userList.value[indexPath.row])
    }
    
    func willDisplayUser(at indexPath: IndexPath) {
        if indexPath.count == userList.value.count - 1 {
            loadData()
        }
    }
    
    func loadData() {
        usersRepository.getUsers(page: page)
            .done { [weak users] data in
                guard let users = users else { return }
                users.accept(users.value + data.results)
            }
            .catch { error in
                print(error)
        }
    }
    
    private func createUserCellViewModel(user: User) -> UserCellViewModel {
        var name = ""
        if let n = user.name {
            name = n.first.capitalizingFirstLetter() + " " + n.last.capitalizingFirstLetter()
        }
        
        return UserCellViewModel(name: name,
                                 phome: user.phone,
                                 imageUrl: URL(string: user.picture?.large ?? ""))
    }
    
}
