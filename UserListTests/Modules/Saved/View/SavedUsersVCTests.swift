//
//  SavedUsersVCTest.swift
//  UserListTests
//
//  Created by Yurii Chudnovets on 8/28/19.
//  Copyright © 2019 yura. All rights reserved.
//

import XCTest
import RxBlocking
import RxTest
import RxSwift
import RxRelay
@testable import UserList

class SavedUsersVCTests: XCTestCase, RootVCForTesting {
    
    lazy var vc: UIViewController = {
        return UINavigationController(rootViewController: SavedUsersVC(viewModel: viewModel))
    }()
    var viewModel = SavedUsersViewModelMock()
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        replaceRootVC()
        
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
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
        
        let test = BehaviorRelay<UserViewModel?>(value: nil)
        
        viewModel.usersStore.state
            .subscribe(onNext: { (state) in
                print(state)
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("Users state completed")
            }) {
                print("Users state disposed")
            }
            .disposed(by: disposeBag)

        test
            .map { vm -> Action in
                if vm != nil {
                    return Action.add(viewModel: vm!)
                } else {
                    return Action.remove(viewModel: userViewModel)
                }
            }
            .bind(to: viewModel.usersStore)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(view.noDataLabel.isHidden, false)
        test.accept(userViewModel)
        XCTAssertEqual(try viewModel.usersStore.state.toBlocking().first()?.viewModels.count, 1)
        XCTAssertEqual(view.noDataLabel.isHidden, true)
        
        test.accept(nil)
        XCTAssertEqual(try viewModel.usersStore.state.toBlocking().first()?.viewModels.count, 0)
        XCTAssertEqual(view.noDataLabel.isHidden, false)
        
    }
    
    
}
