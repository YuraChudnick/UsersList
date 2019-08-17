//
//  UsersViewModel.swift
//  UserListKit
//
//  Created by Yurii Chudnovets on 7/19/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RxSwift
import RxRelay

protocol RxUsersViewModelProtocol {
    var userList: BehaviorRelay<[UserCellViewModel]> { get }
    func selectUser(at indexPath: IndexPath)
    func willDisplayUser(at indexPath: IndexPath)
    func loadData()
}

class RxUsersViewModel: RxUsersViewModelProtocol {
    
    let usersRepository: UsersRepository
    private let users = BehaviorRelay<[User]>(value: [])
    var userList = BehaviorRelay<[UserCellViewModel]>(value: [])
    let disposeBag = DisposeBag()
    let isLoading = BehaviorRelay<Bool>(value: false)
    private var page = 0
    
    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
        setup()
    }
    
    fileprivate func setup() {
        users
            .asObservable()
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
        guard !isLoading.value, indexPath.row == userList.value.count - 1 else {
            return
        }
        loadData()
    }
    
    func loadData() {
        isLoading.accept(true)
        print("Start loadind page - \(page).")
        usersRepository.getUsers(page: page)
            .done { [weak self] data in
                guard let self = self else { return }
                self.isLoading.accept(false)
                self.users.accept(self.users.value + data.results)
                self.page += 1
            }
            .catch { [weak self] error in
                print(error)
                self?.isLoading.accept(false)
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
