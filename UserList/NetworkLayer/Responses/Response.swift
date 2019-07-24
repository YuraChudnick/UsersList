//
//  Response.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Foundation

public enum BackendError: Error {
    case noData(reason: String)
}

public enum NetworkError: Error {
    case unknown(reason: String)
}

public enum Response<T: Codable> {
    
    case data(_: T)
    case error(_: Int?, _: Error?)
    
    init(_ response: (r: HTTPURLResponse?, data: Any?, error: Error?)) {
        
        guard response.r?.statusCode == 200, response.error == nil else {
            self = .error(response.r?.statusCode, response.error)
            return
        }
        
        guard let d = response.data as? Data else {
            self = .error(response.r?.statusCode, response.error)
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(T.self, from: d)
            #if DEBUG
            //                let json = try JSONSerialization.jsonObject(with: d, options: .mutableContainers)
            //                print("\nResponseCodable -> \(T.self): ")
            //                print(json)
            #endif
            self = .data(data)
        } catch {
            self = .error(400, BackendError.noData(reason: "Did not get data in response"))
        }
    }
    
}
