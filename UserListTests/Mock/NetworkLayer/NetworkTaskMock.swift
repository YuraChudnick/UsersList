//
//  NetworkTaskMock.swift
//  UserListTests
//
//  Created by Yurii Chudnovets on 8/27/19.
//  Copyright © 2019 yura. All rights reserved.
//

import PromiseKit
@testable import UserList

struct NetworkTaskMock: NetworkTaskProtocol {
    
    func execute<T: Codable>(with request: Request) -> Promise<T> {
        return Promise<T> { seal in
            if T.self is UsersResponse.Type {
                let user = User()
                user.fillMockData()
                let response = UsersResponse(results: [user])
                seal.fulfill(response as! T)
            } else {
                seal.reject(NetworkError.unknown(reason: "unknown"))
            }
        }
    }
    
}
