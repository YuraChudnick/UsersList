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
    var avatar: BehaviorRelay<UIImage?> { get }
    func loadAvatar()
    func pressedChangeAvatar()
    func pressedSave()
}

class EditUserProfileViewModel: EditUserProfileViewModelProtocol {

    let repository: EditUserRepositoryProtocol
    let imageManager: ImageCacheManagerProtocol
    
    let user: User
    var avatar = BehaviorRelay<UIImage?>(value: nil)
    
    var router: EditUserRouterProtocol!
    var userParameterViewModels: BehaviorRelay<[UserParameterViewModel]>
    
    init(user: User, repository: EditUserRepositoryProtocol, imageManager: ImageCacheManagerProtocol) {
        self.repository = repository
        self.imageManager = imageManager
        self.user = user
        let parameterViewModels = [UserParameterViewModel(type: .firstName, value: user.name?.first ?? ""),
                                   UserParameterViewModel(type: .lastName, value: user.name?.last ?? ""),
                                   UserParameterViewModel(type: .email, value: user.email),
                                   UserParameterViewModel(type: .phone, value: user.phone)]
        userParameterViewModels = BehaviorRelay(value: parameterViewModels)
    }
    
    func loadAvatar() {
        imageManager.loadImage(key: user.getAvatarKey(.large))
            .done { [weak self] image in
                self?.avatar.accept(image)
            }
            .catch { [weak self] (error) in
                print(error)
                self?.loadImage()
            }
    }
    
    func loadImage() {
        do {
            imageManager.loadImage(url: try user.getAvatarUrl(.large))
                .done { [weak self] (image) in
                    self?.avatar.accept(image)
                }
                .catch { (error) in
                    print(error)
            }
        } catch {
            print(error)
        }
    }
    
    func pressedChangeAvatar() {
        router.presentPhotoPicker()
    }
    
    func pressedSave() {
        var newValues = (first: "", last: "", email: "", phone: "", image: "image_\(Date().timeIntervalSinceNow)")
        for vm in userParameterViewModels.value {
            switch vm.type {
            case .firstName:
                newValues.first = vm.value.value
            case .lastName:
                newValues.last = vm.value.value
            case .email:
                newValues.email = vm.value.value
            case .phone:
                newValues.phone = vm.value.value
            }
        }
        if let image = avatar.value {
            imageManager.saveImage(image: image, key: newValues.image)
        }
        repository.save(user: user, with: newValues)
        router.back()
    }
    
}
