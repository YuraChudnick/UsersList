//
//  UsersViewModelTests.swift
//  UserListTests
//
//  Created by yura on 9/1/19.
//  Copyright © 2019 yura. All rights reserved.
//

import XCTest
import RxBlocking
import RxTest
import RxSwift
import PromiseKit
@testable import UserList

class UsersViewModelTests: BaseTestCase {
    
    let router = UsersRouterMock()
    let repository = UsersRepositoryMock()
    var viewModel: UsersViewModel!
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    
    override func setUp() {
        super.setUp()
        
        viewModel = UsersViewModel(usersRepository: self.repository)
        viewModel.router = self.router
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        
        PromiseKit.conf.Q.map = nil
        PromiseKit.conf.Q.return = nil
    }
    
    
    override func tearDown() {
        super.tearDown()
        scheduler = nil
        disposeBag = nil
    }
    
    func testLoadData() {
        let userListCount = scheduler.createObserver(Int.self)
        
        viewModel.userList
            .asDriver()
            .map({ $0.count })
            .drive(userListCount)
            .disposed(by: disposeBag)
        
        viewModel.userList
            .subscribe(onNext: { (list) in
                print(list)
            })
        .disposed(by: disposeBag)
        
//        viewModel.loadTrigger
//            .subscribe(onNext: { [weak self] () in
//                self?.repository.fullFillUser()
//                print("Load data!!!!!!")
//            })
//            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(10, ()),
                                        .next(20, ()),
                                        .next(30, ())])
            .bind(to: viewModel.loadTrigger)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        print(userListCount.events.count)
        XCTAssertEqual(userListCount.events, [
            .next(0, 0),
            .next(10, 1),
            .next(20, 2),
            .next(30, 3)])
        
        XCTAssertEqual(viewModel.page, 3)
    }
    
    func testRefreshing() {
        let refreshing = scheduler.createObserver(Bool.self)
        
        viewModel.isRefreshing
            .asDriver()
            .drive(refreshing)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, false),
                                        .next(20, true)])
            .bind(to: viewModel.isRefreshing)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        print(refreshing.events)
        XCTAssertEqual(refreshing.events, [.next(0, true),
                                           .next(10, false),
                                           .next(20, true)])
        
    }
    
}
