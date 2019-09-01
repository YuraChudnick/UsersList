//
//  EditUserRouterTests.swift
//  UserListTests
//
//  Created by yura on 9/1/19.
//  Copyright © 2019 yura. All rights reserved.
//

import XCTest
@testable import UserList

class EditUserRouterTests: XCTestCase, RootVCForTesting {
    
    var vc: UIViewController = EditUserVCMock()
    lazy var router: EditUserRouter = {
        return EditUserRouter(vc: self.vc as! EditUserVCMock)
    }()
    
    override func setUp() {
        replaceRootVC()
        super.setUp()
    }
    
    override func tearDown() {
        resetRootVC()
        super.tearDown()
    }
    
    func testPhotoPicker() {
        router.presentPhotoPicker()
        XCTAssertNotNil(UIApplication.shared.keyWindow?.rootViewController?.presentedViewController as? UIAlertController)
        let alert = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController as! UIAlertController
        
        
        XCTAssertEqual(alert.actions.count, 3)
        XCTAssertEqual(alert.preferredStyle, UIAlertController.Style.actionSheet)
    
        XCTAssertEqual(alert.actions[0].title, "Cancel")
        XCTAssertEqual(alert.actions[0].style, UIAlertAction.Style.cancel)
        
        XCTAssertEqual(alert.actions[1].title, "Photo Library")
        XCTAssertEqual(alert.actions[1].style, UIAlertAction.Style.default)
        
        XCTAssertEqual(alert.actions[2].title, "Camera")
        XCTAssertEqual(alert.actions[2].style, UIAlertAction.Style.default)
        
        alert.dismiss(animated: false, completion: nil)
    }
    
    func testPhotoLibrary() {
        router.presentPhotoLibrary()
        router.photoPickerManager.imagePickerController(UIImagePickerController(), didFinishPickingMediaWithInfo: [.originalImage: UIImage(named: "tab_users")!])
        
        XCTAssertNotNil((vc as! EditUserVCMock).testImage)
    }
    
    func testBack() {
        router.back()
    }
    
}
