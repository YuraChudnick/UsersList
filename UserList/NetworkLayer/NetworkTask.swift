//
//  NetworkTask.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Alamofire

class NetworkTask<T: Codable>: NetworkTaskProtocol {
    
    typealias ResponseCodable = Response<T>
    
    var request: Request
    
    required init(request: Request) {
        self.request = request
    }
    
    func execute(completionHandler: @escaping (Response<T>) -> Void) {
        Alamofire.request(request).responseData { (response) in
            completionHandler(Response((r: response.response,
                                        data: response.data,
                                        error: response.error)))
        }
    }
    
}
