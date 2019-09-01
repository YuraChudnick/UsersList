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
        
        scheduler.createColdObservable([.next(300, ()),
                                        .next(500, ())])
            .bind(to: viewModel.loadTrigger)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        print(userListCount.events.count)
        XCTAssertEqual(userListCount.events, [
            .next(0, 0),
            .next(3000, 1)])
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
        
        print(refreshing.events)
        XCTAssertEqual(refreshing.events, [.next(0, true),
                                           .next(10, false),
                                           .next(20, true)])
    }
    
}
