//
//  EditUserProfileModel.swift
//  UserList
//
//  Created by Yurii Chudnovets on 12/29/18.
//  Copyright © 2018 yura. All rights reserved.
//

import Foundation
import CoreData

class EditUserProfileModel: EditUserProfileModelProtocol {

    private let userData: UserProtocol?
    
    required init(userData: UserProtocol?) {
        self.userData = userData
    }
    
}
