//
//  RootVCForTesting.swift
//  UserListTests
//
//  Created by yura on 8/27/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit
import XCTest

protocol RootVCForTesting {
    var vc: UIViewController { get }
    func replaceRootVC()
}

extension RootVCForTesting where Self: XCTestCase {
    
    func replaceRootVC() {
        UIApplication.shared.keyWindow?.rootViewController = vc
        _ = vc.view
    }
    
}
