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
    
    lazy var vc: UIViewController = UsersVC(viewModel: self.viewModel)
    let viewModel = UserViewModelMock()
    
    override func setUp() {
        replaceRootVC()
    }
    
    override func tearDown() {
        resetRootVC()
    }
    
    func testTitle() {
        XCTAssertEqual(vc.title, "Users")
    }
    
    func testRefreshing() {
        viewModel.isRefreshing.accept(false)
        let view = (vc.view as! UsersRootView)
        XCTAssertFalse(view.refreshControl.isRefreshing)
        viewModel.isRefreshing.accept(true)
        XCTAssertEqual(try viewModel.isRefreshing.toBlocking().first(), true)
        XCTAssertNotNil(try view.refreshControl.rx.controlEvent(.valueChanged).toBlocking().first())
    }
    
}
