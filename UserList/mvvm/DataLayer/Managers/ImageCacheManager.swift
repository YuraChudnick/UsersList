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

enum ImageCacheError: Error {
    case noImageFor(key: String)
    
    var localizedDescription: String {
        switch self {
        case .noImageFor(let key):
            return "No image stored for \(key)"
        }
    }
}

protocol ImageCacheManagerProtocol {
    func loadImage(url: URL) -> Promise<UIImage>
    func loadImage(key: String) -> Promise<UIImage>
    func saveImage(image: UIImage, key: String, completionHandler: (() -> Void)?)
    func deleteImage(with key: String)
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
    
    func loadImage(key: String) -> Promise<UIImage> {
        return Promise { seal in
            let image = ImageCache.default.retrieveImageInDiskCache(forKey: key)
            if image != nil {
                seal.fulfill(image!)
            } else {
                seal.reject(ImageCacheError.noImageFor(key: key))
            }
        }
    }
    
    func saveImage(image: UIImage, key: String, completionHandler: (() -> Void)?) {
        ImageCache.default.store(image, forKey: key, completionHandler: completionHandler)
    }
    
    func deleteImage(with key: String) {
        ImageCache.default.removeImage(forKey: key)
    }
    
}
