//
//  SavedUsersVCTest.swift
//  UserListTests
//
//  Created by Yurii Chudnovets on 8/28/19.
//  Copyright © 2019 yura. All rights reserved.
//

import XCTest
@testable import UserList

class SavedUsersVCTests: XCTestCase, RootVCForTesting {
    
    lazy var vc: UIViewController = {
        return SavedUsersVC(viewModel: viewModel)
    }()
    var viewModel = SavedUsersViewModelMock()
    
    override func setUp() {
        replaceRootVC()
    }
    
    override func tearDown() {
        
    }
    
    func testViewIsLoaded() {
        
        XCTAssertTrue(vc.isViewLoaded, "SavedVC did not load")
    }
    
    
}
