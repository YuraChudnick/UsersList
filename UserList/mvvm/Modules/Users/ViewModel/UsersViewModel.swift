//
//  UsersViewModel.swift
//  UserListKit
//
//  Created by Yurii Chudnovets on 7/19/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RxSwift
import RxRelay

protocol UsersViewModelProtocol {
    var userList: BehaviorRelay<[UserViewModel]> { get }
    var loadTigger: PublishRelay<Void> { get }
    var isRefreshing: BehaviorRelay<Bool> { get }
    func selectUser(at indexPath: IndexPath)
    func willDisplayUser(at indexPath: IndexPath)
    func loadData()
}

class UsersViewModel: UsersViewModelProtocol {
    
    let usersRepository: UsersRepositoryProtocol
    var router: UsersRouterProtocol!
    
    private let users = BehaviorRelay<[User]>(value: [])
    var userList = BehaviorRelay<[UserViewModel]>(value: [])
    var isRefreshing = BehaviorRelay<Bool>(value: false)
    var loadTigger = PublishRelay<Void>()
    let disposeBag = DisposeBag()
    private var page = 0
    
    init(usersRepository: UsersRepositoryProtocol) {
        self.usersRepository = usersRepository
        setup()
    }
    
    fileprivate func setup() {
        users
            .toUserViewModels()
            .bind(to: userList)
            .disposed(by: disposeBag)
        loadTigger.subscribe(onNext: { [weak self] in
                self?.loadData()
            })
            .disposed(by: disposeBag)
    }
    
    func selectUser(at indexPath: IndexPath) {
        router.presentEditScreen(with: users.value[indexPath.row])
    }
    
    func willDisplayUser(at indexPath: IndexPath) {
        guard !isRefreshing.value, indexPath.row == userList.value.count - 1 else {
            return
        }
        loadData()
    }
    
    func loadData() {
        isRefreshing.accept(true)
        print("Start loadind page - \(page).")
        usersRepository.getUsers(page: page)
            .done { [weak self] data in
                guard let self = self else { return }
                self.isRefreshing.accept(false)
                self.users.accept(self.users.value + data.results)
                self.page += 1
            }
            .catch { [weak self] error in
                print(error)
                self?.isRefreshing.accept(false)
        }
    }
    
}
