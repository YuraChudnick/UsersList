//
//  ImageCacheManagerMock.swift
//  UserListTests
//
//  Created by Yurii Chudnovets on 9/3/19.
//  Copyright © 2019 yura. All rights reserved.
//

import PromiseKit
@testable import UserList

class ImageCacheManagerMock: ImageCacheManagerProtocol {
    
    let image = UIImage(named: "tab_users")!
    
    var savedImage: UIImage?
    var key: String?
    
    func loadImage(url: URL) -> Promise<UIImage> {
        let deferredPromise = Promise<UIImage>.pending()
        deferredPromise.resolver.fulfill(image)
        return deferredPromise.promise
    }
    
    func loadImage(key: String) -> Promise<UIImage> {
        self.key = key
        let deferredPromise = Promise<UIImage>.pending()
        deferredPromise.resolver.fulfill(image)
        return deferredPromise.promise
    }
    
    func saveImage(image: UIImage, key: String, completionHandler: (() -> Void)?) {
        savedImage = image
        self.key = key
    }
    
    func deleteImage(with key: String) {
        self.key = key
    }
    
}
