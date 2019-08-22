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

enum ParameterViewModelType {
    case avatar
    case parameter(viewModel: UserParameterViewModel)
}

protocol EditUserProfileViewModelProtocol {
    var userParameterViewModels: BehaviorRelay<[ParameterViewModelType]> { get }
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
    var userParameterViewModels: BehaviorRelay<[ParameterViewModelType]>
    
    init(user: User, repository: EditUserRepositoryProtocol, imageManager: ImageCacheManagerProtocol) {
        self.repository = repository
        self.imageManager = imageManager
        self.user = user
        let parameterViewModels = [ParameterViewModelType.avatar,
                                   ParameterViewModelType.parameter(viewModel: UserParameterViewModel(type: .firstName, value: user.name?.first ?? "")),
                                   ParameterViewModelType.parameter(viewModel: UserParameterViewModel(type: .lastName, value: user.name?.last ?? "")),
                                   ParameterViewModelType.parameter(viewModel: UserParameterViewModel(type: .email, value: user.email)),
                                   ParameterViewModelType.parameter(viewModel: UserParameterViewModel(type: .phone, value: user.phone))]
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
            switch (vm) {
            case .parameter(let viewModel):
                switch viewModel.type {
                case .firstName:
                    newValues.first = viewModel.value.value
                case .lastName:
                    newValues.last = viewModel.value.value
                case .email:
                    newValues.email = viewModel.value.value
                case .phone:
                    newValues.phone = viewModel.value.value
                }
            default:
                continue
            }
            
        }
        if let image = avatar.value {
            imageManager.saveImage(image: image, key: newValues.image)
        }
        repository.save(user: user, with: newValues)
        router.back()
    }
    
}
