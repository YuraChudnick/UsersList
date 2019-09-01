//
//  EditUserVCMock.swift
//  UserListTests
//
//  Created by yura on 9/1/19.
//  Copyright © 2019 yura. All rights reserved.
//

import XCTest
import UIKit
@testable import UserList

class EditUserVCMock: UIViewController, PhotoPickerManagerDelegate {

    var testImage: UIImage?
    
    func manager(_ manager: PhotoPickerManager, didPickImage image: UIImage) {
        testImage = image
    }
    
}
