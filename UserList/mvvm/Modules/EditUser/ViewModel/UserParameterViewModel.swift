//
//  UserParameterViewModel.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/16/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RxSwift
import RxRelay

enum ParameterType: String {
    case firstName = "First name"
    case lastName  = "Last name"
    case email     = "Email"
    case phone     = "Phone"
}

protocol UserParameterViewModelProtocol {
    var value: BehaviorRelay<String> { get }
    var type: ParameterType { get }
}

struct UserParameterViewModel: UserParameterViewModelProtocol {
    
    var value: BehaviorRelay<String>
    var type: ParameterType
    
    init(type: ParameterType, value: String) {
        self.type = type
        self.value = BehaviorRelay(value: value)
    }
    
}
