//
//  BaseTestCase.swift
//  UserListTests
//
//  Created by yura on 9/1/19.
//  Copyright © 2019 yura. All rights reserved.
//

import XCTest

class BaseTestCase: XCTestCase, RootVCForTesting {
    var vc: UIViewController = UIViewController()
    
    override func setUp() {
        replaceRootVC()
        super.setUp()
    }
    
    override func tearDown() {
        resetRootVC()
        super.tearDown()
    }
}
