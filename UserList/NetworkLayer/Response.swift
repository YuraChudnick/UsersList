//
//  Response.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Foundation

public enum Response {
    
    case data(_: Any)
    case error(_: Int?, _: Error?)
    
    init(_ response: (r: HTTPURLResponse?, data: Any?, error: Error?)) {
        
        guard response.r?.statusCode == 200, response.error == nil else {
            self = .error(response.r?.statusCode, response.error)
            return
        }
        
        guard let d = response.data else {
            self = .error(response.r?.statusCode, response.error)
            return
        }
        
        self = .data(d)
    }
    
}
