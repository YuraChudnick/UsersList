//
//  EditUserModuleBuilderTests.swift
//  UserListTests
//
//  Created by yura on 9/1/19.
//  Copyright © 2019 yura. All rights reserved.
//

import XCTest
@testable import UserList

class EditUserModuleBuilderTests: XCTestCase, RootVCForTesting {
    
    var vc: UIViewController = UIViewController()
    
    override func setUp() {
        replaceRootVC()
        super.setUp()
    }
    
    override func tearDown() {
        resetRootVC()
        super.tearDown()
    }
    
    func testBuildModule() {
        let user = User()
        user.fillMockData()
        let vc = EditUserModuleBuilder().create(with: user)
        XCTAssertTrue(vc is EditUserVC)
    }
    
}
