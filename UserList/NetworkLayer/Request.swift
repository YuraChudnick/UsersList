//
//  Request.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Alamofire

protocol Request: URLRequestConvertible {
    
    var baseUrl: String { get }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: [String: Any] { get }
    
    var headers: [String: Any]? { get }
    
}

extension Request {
    
    var path: String { return "" }
    
    var method: HTTPMethod { return .get }
    
    var headers: [String: Any]? { return nil }
    
    var parameters: [String: Any] { return [:] }
    
}
