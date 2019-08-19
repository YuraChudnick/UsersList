//
//  EditUserProfileViewModel.swift
//  UserList
//
//  Created by yura on 8/17/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RxSwift
import RxRelay
import UIKit.UIImage

protocol EditUserProfileViewModelProtocol {
    var userParameterViewModels: BehaviorRelay<[UserParameterViewModel]> { get }
    func pressedChangeAvatar()
}

class EditUserProfileViewModel: EditUserProfileViewModelProtocol {
    
    let repository: EditUserRepositoryProtocol
    
    let user: User
    let avatar = BehaviorRelay<UIImage?>(value: nil)
    
    var router: EditUserRouterProtocol!
    var userParameterViewModels: BehaviorRelay<[UserParameterViewModel]>
    
    init(user: User, repository: EditUserRepositoryProtocol) {
        self.repository = repository
        self.user = user
        let parameterViewModels = [UserParameterViewModel(type: .firstName, value: user.name?.first ?? ""),
                                   UserParameterViewModel(type: .lastName, value: user.name?.last ?? ""),
                                   UserParameterViewModel(type: .email, value: user.email),
                                   UserParameterViewModel(type: .phone, value: user.phone)]
        userParameterViewModels = BehaviorRelay(value: parameterViewModels)
    }
    
    func pressedChangeAvatar() {
        router.presentPhotoPicker()
    }
    
}
