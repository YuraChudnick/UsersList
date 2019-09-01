//
//  UserRepositoryTest.swift
//  UserListTests
//
//  Created by yura on 8/27/19.
//  Copyright © 2019 yura. All rights reserved.
//

import XCTest
@testable import UserList

class UserRepositoryTests: XCTestCase, RootVCForTesting, RealmForTesting {
    
    var vc: UIViewController = UIViewController()
    var usersRepository: UsersRepositoryProtocol!
    
    override func setUp() {
        replaceRootVC()
        usersRepository = UsersRepository(networkTask: NetworkTaskMock(),
                                          realmProvider: RealmProvider.usersTest)
    }
    
    override func tearDown() {
        resetRootVC()
    }
    
    func testGetUsers() {
        let expectation = self.expectation(description: "promiseKit")
        usersRepository.getUsers(page: 1)
            .done { response in
                XCTAssertTrue(response.results.count == 1)
                expectation.fulfill()
            }.catch { (error) in
                XCTAssertThrowsError(error)
                expectation.fulfill()
            }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSavingAndUpdating() {
        deleteAllFromRealm()
        let testUser = User()
        var newData = (first: "Test", last: "Testable", email: "test@testable.com", phone: "991", image: "logo")
        usersRepository.save(user: testUser, with: newData)
        
        let result = usersRepository.getSavedUsers()
        
        XCTAssertTrue(result.count == 1)
        XCTAssertTrue(result[0].phone == "991", "Wrong data from realm!!!")
        
        //test updating
        newData.phone = "992"
        usersRepository.save(user: testUser, with: newData)
        
        XCTAssertTrue(result.count == 1)
        XCTAssertTrue(result[0].phone == "992", "Wrong data from realm!!!")
        XCTAssertTrue(testUser.phone == "992")
    }
    
    func testDeleting() {
        deleteAllFromRealm()
        let testUser = User()
        let newData = (first: "Test", last: "Testable", email: "test@testable.com", phone: "991", image: "logo")
        usersRepository.save(user: testUser, with: newData)
        
        let result = usersRepository.getSavedUsers()
        XCTAssertTrue(result.count == 1)
        
        usersRepository.delete(user: testUser)
        XCTAssertTrue(result.count == 0)
        
        usersRepository.delete(user: User()) //with no realm
    }
    
}
