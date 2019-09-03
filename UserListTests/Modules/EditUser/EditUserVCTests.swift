//
//  EditUserVCTest.swift
//  UserListTests
//
//  Created by yura on 9/1/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit
import XCTest
import RxBlocking
@testable import UserList

class EditUserVCTests: XCTestCase, RootVCForTesting {
    
    lazy var vc: UIViewController = EditUserVC(viewModel: viewModel)
    let viewModel = EditUserViewModelMock()
    let testImage = UIImage(named: "tab_users")!
    
    override func setUp() {
        super.setUp()
        replaceRootVC()
    }
    
    override func tearDown() {
        super.tearDown()
        resetRootVC()
    }
    
    func testParameters() {
        let view = (vc as! EditUserVC).view as! EditUserRootView
        let userPVMs = [UserParameterViewModel(type: .firstName, value: "Test"),
                       UserParameterViewModel(type: .lastName, value: "Testable"),
                       UserParameterViewModel(type: .email, value: "test@test.com"),
                       UserParameterViewModel(type: .phone, value: "991")]
        let parameterViewModels = [ParameterViewModelType.avatar,
                                   ParameterViewModelType.parameter(viewModel: userPVMs[0]),
                                   ParameterViewModelType.parameter(viewModel: userPVMs[1]),
                                   ParameterViewModelType.parameter(viewModel: userPVMs[2]),
                                   ParameterViewModelType.parameter(viewModel: userPVMs[3])]
        
        viewModel.userParameterViewModels.accept([])
        XCTAssertEqual(try viewModel.userParameterViewModels.toBlocking().first()?.count, 0)
        viewModel.userParameterViewModels.accept(parameterViewModels)
        XCTAssertEqual(try viewModel.userParameterViewModels.toBlocking().first()?.count, parameterViewModels.count)
        
        //test simple cell
        let firstNameCell = view.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! UserParameterTableViewCell
        XCTAssertEqual(firstNameCell.textField.text, userPVMs[0].value.value)
        let newName = "New name"
        firstNameCell.textField.text = newName
        firstNameCell.textField.sendActions(for: .valueChanged)
        XCTAssertEqual(try userPVMs[0].value.toBlocking().first(), newName)
        
        //test avatar cell
        let avatarCell = view.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! UserAvatarTableViewCell
        viewModel.isPressedChangedAvatar = false
        avatarCell.changeButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(viewModel.isPressedChangedAvatar)
        viewModel.isPressedChangedAvatar = false
        XCTAssertEqual(avatarCell.avatarImageView.layer.cornerRadius, avatarCell.avatarImageView.bounds.width/2)
        
        //change logo
        viewModel.avatar.accept(nil)
        XCTAssertNil(avatarCell.avatarImageView.image)
        viewModel.avatar.accept(testImage)
        XCTAssertEqual(avatarCell.avatarImageView.image, testImage)
    }
    
    func testSaveButton() {
        let viewController = vc as! EditUserVC
        viewModel.isPressedSave = false
        viewController.pressedSave()
        XCTAssertTrue(viewModel.isPressedSave)
        viewModel.isPressedSave = false
    }
    
    func testPhotoPickerManagerDelegate() {
        let viewController = vc as! EditUserVC
        viewModel.avatar.accept(nil)
        viewController.manager(PhotoPickerManager(presentingViewController: vc), didPickImage: testImage)
        XCTAssertEqual(try viewModel.avatar.toBlocking().first(), testImage)
        viewModel.avatar.accept(nil)
    }
    
}
