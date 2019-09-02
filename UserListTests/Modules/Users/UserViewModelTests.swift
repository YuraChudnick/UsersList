//
//  UserViewModelTests.swift
//  UserListTests
//
//  Created by Yurii Chudnovets on 9/2/19.
//  Copyright © 2019 yura. All rights reserved.
//

import XCTest
import RxBlocking
import RxTest
import RxSwift
@testable import UserList

class UserViewModelTests: BaseTestCase {
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var userViewModel: UserViewModel!
    
    let user = User()
    
    override func setUp() {
        super.setUp()
        
        user.fillMockData()
        userViewModel = UserViewModel(user: user)
        
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        super.tearDown()
        
        scheduler = nil
        disposeBag = nil
    }
    
    func testUpdate() {
        let name = "Test Testable"
        let phone = "+30000"
        let imageUrl = "https://randomuser.me/api/portraits/men/21.jpg"
        
        user.name?.first = "test"
        user.name?.last = "testable"
        user.phone = phone
        user.picture?.large = imageUrl
        
        userViewModel.update()
        
        XCTAssertEqual(try userViewModel.name.toBlocking().first(), name)
        XCTAssertEqual(try userViewModel.phone.toBlocking().first(), phone)
        XCTAssertEqual(try userViewModel.imageUrl.toBlocking().first()??.absoluteString, imageUrl)
        
        
    }
    
}
