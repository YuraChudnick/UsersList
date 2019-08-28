//
//  SavedUsersVCTest.swift
//  UserListTests
//
//  Created by Yurii Chudnovets on 8/28/19.
//  Copyright © 2019 yura. All rights reserved.
//

import XCTest
import RxBlocking
import RxSwift
import RxRelay
@testable import UserList

class SavedUsersVCTests: XCTestCase, RootVCForTesting {
    
    lazy var vc: UIViewController = {
        return UINavigationController(rootViewController: SavedUsersVC(viewModel: viewModel))
    }()
    var viewModel = SavedUsersViewModelMock()
    
    override func setUp() {
        replaceRootVC()
    }
    
    override func tearDown() {
        resetRootVC()
    }
    
    func testViewIsLoaded() {
        XCTAssertTrue(vc.isViewLoaded, "SavedVC did not load")
    }
    
    func testViewType() {
        XCTAssertNil(vc.view as? SavedUsersRootView)
    }
    
    func testNoDataLabel() {
        let user = User()
        user.fillMockData()
        let userViewModel = UserViewModel(user: user)
        let view = (vc as! UINavigationController).topViewController?.view as! SavedUsersRootView
        XCTAssertFalse(view.noDataLabel.isHidden)
        
        XCTAssertFalse(try viewModel.usersStore.state.toBlocking().first()?.viewModels.isEmpty ?? true)
        //XCTAssertTrue(view.noDataLabel.isHidden)
    }
    
    
}
