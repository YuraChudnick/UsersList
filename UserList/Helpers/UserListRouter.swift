//
//  UserListRouter.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//

import Alamofire

public enum UserListRouter: URLRequestConvertible {
    
    enum Constants {
        static let baseUrl = "https://randomuser.me"
    }
    
    case userlist(quantity: Int)
    case pagination(page: Int, quantity: Int)
    
    var method: HTTPMethod {
        switch self {
        case .userlist, .pagination:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .userlist, .pagination:
            return "/api"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .userlist(let quantity):
            return ["results": quantity]
        case .pagination(let page, let quantity):
            return ["page": page, "results": quantity, "seed": "abc"]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(20)
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
}