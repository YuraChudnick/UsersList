//
//  UsersVCTests.swift
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

class UsersVCTests: XCTestCase, RootVCForTesting {
    
    lazy var vc: UIViewController = {
        return UINavigationController(rootViewController: UsersVC(viewModel: self.viewModel))
    }()
    
    let viewModel = UserViewModelMock()
    
    override func setUp() {
        replaceRootVC()
    }
    
    override func tearDown() {
        resetRootVC()
    }
    
}
