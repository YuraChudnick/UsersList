//
//  EditUserViewModelMock.swift
//  UserListTests
//
//  Created by Yurii Chudnovets on 9/3/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RxSwift
import RxRelay
@testable import UserList

class EditUserViewModelMock: EditUserViewModelProtocol {
    var userParameterViewModels: BehaviorRelay<[ParameterViewModelType]> = BehaviorRelay(value: [])
    
    var avatar: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    
    var isLoadingAvatar = false
    var isPressedChangedAvatar = false
    var isPressedSave = false
    
    func loadAvatar() {
        isLoadingAvatar = true
    }
    
    func pressedChangeAvatar() {
        isPressedChangedAvatar = true
    }
    
    func pressedSave() {
        isPressedSave = true
    }
    
}
