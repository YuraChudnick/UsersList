//
//  NetworkTask.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class NetworkTask<T: Mappable>: NetworkTaskProtocol {
    
    var request: Request
    
    required init(request: Request) {
        self.request = request
    }
    
    func execute(completionHandler: @escaping (Response) -> Void) {
        Alamofire.request(request).responseObject { (response: DataResponse<T>) in
            completionHandler(Response((r: response.response, data: response.result.value, error: response.result.error)))
        }
    }
    
}
