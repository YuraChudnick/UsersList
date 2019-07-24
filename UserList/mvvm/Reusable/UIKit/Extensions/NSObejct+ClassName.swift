//
//  NSObejct+ClassName.swift
//  UserList
//
//  Created by Yurii Chudnovets on 7/22/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
