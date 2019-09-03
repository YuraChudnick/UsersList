//
//  EditUserRouterMock.swift
//  UserListTests
//
//  Created by Yurii Chudnovets on 9/3/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit
@testable import UserList

class EditUserRouterMock: EditUserRouterProtocol {
    
    var isBackCalled = false
    var isPhotoPickerCalled = false
    
    func presentPhotoPicker() {
        isPhotoPickerCalled = true
    }
    
    func back() {
        isBackCalled = true
    }
    
}
