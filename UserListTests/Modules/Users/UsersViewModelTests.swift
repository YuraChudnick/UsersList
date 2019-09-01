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
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    lazy var viewModel: UsersViewModel = {
        let vm = UsersViewModel(usersRepository: self.repository)
        vm.router = self.router
        return vm
    }()
    
    override func setUp() {
        super.setUp()
        
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
            .map({ $0.count })
            .bind(to: userListCount)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(2, ()), .next(4, ()), .next(6, ())])
            .bind(to: viewModel.loadTrigger)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(userListCount.events, [
            .next(2, 1),
            .next(4, 2),
            .next(6, 2)])
    }
    
}
