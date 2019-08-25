//
//  NewNetworkTask.swift
//  UserList
//
//  Created by Yurii Chudnovets on 7/24/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Alamofire
import PromiseKit

protocol NetworkTaskProtocol {
    func execute<T: Codable>(with request: Request) -> Promise<T>
}

struct NetworkTask: NetworkTaskProtocol {
    
    func execute<T: Codable>(with request: Request) -> Promise<T> {
        return Promise<T> { seal in
            Alamofire.request(request).responseData(queue: DispatchQueue.global(qos: .background), completionHandler: { (response) in
                let result = Response<T>((r: response.response,
                                          data: response.data,
                                          error: response.error))
                switch result {
                case .data(let data):
                    seal.fulfill(data)
                case .error(_, let error):
                    seal.reject(error ?? NetworkError.unknown(reason: "unknown"))
                }
            })
        }
    }
    
}
