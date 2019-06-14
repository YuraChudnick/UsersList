//
//  NetworkTaskProtocol.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Foundation

protocol NetworkTaskProtocol: class {
    
    associatedtype ResponseCodable
    
    var request: Request { get }
    
    init(request: Request)
    
    func execute(completionHandler: @escaping (ResponseCodable) -> Void)
    
}
