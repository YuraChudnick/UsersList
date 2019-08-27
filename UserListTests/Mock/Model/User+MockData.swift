//
//  User+MockData.swift
//  UserListTests
//
//  Created by Yurii Chudnovets on 8/27/19.
//  Copyright © 2019 yura. All rights reserved.
//

@testable import UserList

extension User {
    
    func fillMockData() {
        guard self.realm == nil else { return }
        let name = Name()
        name.first = "Test"
        name.last  = "Testable"
        self.name = name
        self.gender = "T"
        self.email = "test@testable.com"
        self.phone = "+380777777777"
        let picture = Picture()
        picture.large = "large"
        picture.medium = "medium"
        picture.thumbnail = "thumbnail"
        self.picture = picture
    }
    
}
