//
//  Array+Extension.swift
//  UserList
//
//  Created by yura on 8/25/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation

extension Collection {
    
    subscript(optional i: Index) -> Iterator.Element? {
        return self.indices.contains(i) ? self[i] : nil
    }
    
}
