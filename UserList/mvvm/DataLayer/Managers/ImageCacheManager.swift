//
//  ImageDownloader.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/19/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit.UIImage
import Kingfisher
import PromiseKit

protocol ImageCacheManagerProtocol {
    func loadImage(url: URL) -> Promise<UIImage>
}

struct ImageCacheManager: ImageCacheManagerProtocol {
    
    func loadImage(url: URL) -> Promise<UIImage> {
        return Promise { seal in
            ImageDownloader.default.downloadImage(with: url,
                                                  completionHandler:
                { (image, error, url, data) in
                    if image != nil {
                        seal.fulfill(image!)
                    }
                    if error != nil {
                        seal.reject(error!)
                    }
            })
        }
    }
}
