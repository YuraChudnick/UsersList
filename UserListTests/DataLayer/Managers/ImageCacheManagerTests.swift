//
//  ImageCacheManagerTests.swift
//  UserListTests
//
//  Created by yura on 9/1/19.
//  Copyright © 2019 yura. All rights reserved.
//

import XCTest
@testable import UserList

class ImageCacheManagerTests: XCTestCase, RootVCForTesting {
    
    var vc: UIViewController = UIViewController()
    let imageCacheManager: ImageCacheManagerProtocol = ImageCacheManager()
    let badURL = URL(string: "https://randomuser.me/api/portraits/men/21--eq.jpg")!
    let goodURL = URL(string: "https://randomuser.me/api/portraits/men/21.jpg")!
    let imageKey = "test_test"
    
    override func setUp() {
        resetRootVC()
    }
    
    override func tearDown() {
        resetRootVC()
    }
    
    func testLoadImage() {
        let expectationBadUrl = self.expectation(description: "load_bad_url")
        
        var isImageExists = true
        imageCacheManager.loadImage(url: badURL)
            .done { image in
                isImageExists = true
                expectationBadUrl.fulfill()
            }.catch { error in
                isImageExists = false
                expectationBadUrl.fulfill()
            }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(isImageExists, "URL is not bad!")
        
        let expectationGoodUrl = self.expectation(description: "load_good_url")
        isImageExists = false
        imageCacheManager.loadImage(url: goodURL)
            .done { image in
                isImageExists = true
                expectationGoodUrl.fulfill()
            }.catch { error in
                isImageExists = false
                expectationGoodUrl.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(isImageExists, "URL is not good!")
    }
    
    func testLoadImageWithKey() {
        let expectationBadKey = self.expectation(description: "load_bad_key")
        
        var isImageExists = true
        imageCacheManager.loadImage(key: imageKey)
            .done { _ in
                isImageExists = true
                expectationBadKey.fulfill()
            }
            .catch { error in
                isImageExists = false
                XCTAssertNotNil(error as? ImageCacheError)
                XCTAssertTrue((error as! ImageCacheError).localizedDescription == "No image stored for \(self.imageKey)", "Wrong description!!!")
                expectationBadKey.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(isImageExists, "Key is not bad!")
        
        
        let expectationSaveImage = self.expectation(description: "save_image")
        imageCacheManager.saveImage(image: UIImage(named: "tab_users")!, key: imageKey) {
            print("saved")
            expectationSaveImage.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        
        let expectationGoodKey = self.expectation(description: "load_good_key")
        isImageExists = false
        imageCacheManager.loadImage(key: imageKey)
            .done { _ in
                isImageExists = true
                expectationGoodKey.fulfill()
            }
            .catch { _ in
                isImageExists = false
                expectationGoodKey.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(isImageExists, "Key is not good!")
        imageCacheManager.deleteImage(with: imageKey)
    }
    
}
