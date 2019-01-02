//
//  UserList.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//

import ObjectMapper

struct UserList: Mappable {
    
    var results: [User] = []
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        results   <-   map["results"]
    }
    
}

struct User: Mappable, UserProtocol {

    var gender: String = ""
    var name: Name?
    var email: String = ""
    var phone: String = ""
    var picture: Picture?
    var imageForSaving: NSData?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        gender    <-   map["gender"]
        name      <-   map["name"]
        email     <-   map["email"]
        phone     <-   map["phone"]
        picture   <-   map["picture"]
    }
    
    func getFirstName() -> String {
        return name?.first ?? ""
    }
    
    func getLastName() -> String {
        return name?.last ?? ""
    }
    
    func getGender() -> String {
        return gender
    }
    
    func getEmail() -> String {
        return email
    }
    
    func getPhone() -> String {
        return phone
    }
    
    func getImage() -> UIImage? {
        return imageForSaving != nil ? UIImage(data: self.imageForSaving! as Data) : nil
    }
    
    func getImageName() -> String? {
        return picture?.large
    }
    
    func getImageData() -> NSData? {
        return imageForSaving
    }
    
    mutating func setFirstName(first: String) {
        name?.first = first
    }
    
    mutating func setLastName(last: String) {
        name?.last = last
    }
    
    mutating func setEmail(email: String) {
        self.email = email
    }
    
    mutating func setPhone(phone: String) {
        self.phone = phone
    }
    
    mutating func setImage(data: NSData?) {
        imageForSaving = data
    }
    
}

struct Name: Mappable {
    
    var title: String = ""
    var first: String = ""
    var last: String = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        title   <-   map["title"]
        first   <-   map["first"]
        last    <-   map["last"]
    }
    
}

struct Picture: Mappable {
    
    var large: String = ""
    var medium: String = ""
    var thumbnail: String = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        large      <-    map["large"]
        medium     <-    map["medium"]
        thumbnail  <-    map["thumbnail"]
    }
    
}
