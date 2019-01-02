//
//  GetUsersRequest.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Alamofire

enum GetUsersRequest: Request {
    
    case userlist(quantity: Int)
    case pagination(page: Int, quantity: Int)
    
    var baseUrl: String {
        return "https://randomuser.me"
    }
    
    var path: String {
        return "/api"
    }
    
    var parameters: [String : Any] {
        switch self {
        case .userlist(let quantity):
            return ["results": quantity]
        case .pagination(let page, let quantity):
            return ["page": page,
                    "results": quantity,
                    "seed": "abc"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrl.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(20)
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
}
