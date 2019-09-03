//
//  EditUserViewModelTests.swift
//  UserListTests
//
//  Created by Yurii Chudnovets on 9/3/19.
//  Copyright © 2019 yura. All rights reserved.
//

import XCTest
import PromiseKit
@testable import UserList

class EditUserViewModelTests: BaseTestCase {
    
    let user = User()
    let router = EditUserRouterMock()
    let imageCacheManager = ImageCacheManagerMock()
    let repository = UsersRepositoryMock()
    
    lazy var viewModel: EditUserViewModel = {
        let vm = EditUserViewModel(user: self.user, repository: self.repository, imageManager: self.imageCacheManager)
        vm.router = router
        return vm
    }()
    
    override func setUp() {
        super.setUp()
        user.fillMockData()
        
        PromiseKit.conf.Q.map = nil
        PromiseKit.conf.Q.return = nil
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAvatar() {
        viewModel.avatar.accept(nil)
        viewModel.loadAvatar()
        XCTAssertEqual(try viewModel.avatar.toBlocking().first(), imageCacheManager.image)
        viewModel.avatar.accept(nil)
        
        imageCacheManager.withKeyError = true
        viewModel.loadAvatar()
        XCTAssertEqual(try viewModel.avatar.toBlocking().first(), imageCacheManager.image)
        viewModel.avatar.accept(nil)
        
        imageCacheManager.withURLError = true
        viewModel.loadAvatar()
        XCTAssertNil(viewModel.avatar.value)
        
        imageCacheManager.withKeyError = false
        imageCacheManager.withURLError = false
    }
    
    func testPressedChangeAvatar() {
        router.isPhotoPickerCalled = false
        viewModel.pressedChangeAvatar()
        XCTAssertTrue(router.isPhotoPickerCalled)
        router.isPhotoPickerCalled = false
    }
    
    func testPressedSave() {
        clearTempData()
        viewModel.avatar.accept(imageCacheManager.image)
        viewModel.pressedSave()
    
        let newValues = repository.newValues
        XCTAssertNotNil(newValues)
    
        XCTAssertEqual(imageCacheManager.image, imageCacheManager.savedImage)
        XCTAssertEqual(newValues!.image, imageCacheManager.key)
        
        XCTAssertEqual(user.name?.first, newValues!.first)
        XCTAssertEqual(user.name?.last, newValues!.last)
        XCTAssertEqual(user.email, newValues!.email)
        XCTAssertEqual(user.phone, newValues!.phone)
    }
    
    func clearTempData() {
        repository.withoutSaving = true
        repository.newValues = nil
        imageCacheManager.savedImage = nil
        imageCacheManager.key = nil
    }
    
}
