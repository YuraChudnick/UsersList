//
//  UserCellViewModel.swift
//  UserList
//
//  Created by yura on 6/14/19.
//  Copyright © 2019 yura. All rights reserved.
//

import DifferenceKit
import RxSwift
import RxRelay

struct UserViewModel: Differentiable {

    typealias DifferenceIdentifier = UUID
    var differenceIdentifier: UUID = UUID()

    var name: BehaviorRelay<String>
    var phone: BehaviorRelay<String>
    var imageUrl: BehaviorRelay<URL?>
    
    init(user: User) {
        var name = ""
        if let n = user.name {
            name = n.first.capitalizingFirstLetter() + " " + n.last.capitalizingFirstLetter()
        }
        self.name = BehaviorRelay(value: name)
        self.phone = BehaviorRelay(value: user.phone)
        self.imageUrl = BehaviorRelay(value: URL(string: user.picture?.large ?? ""))
    }
    
    func update(with user: User) {
        var name = ""
        if let n = user.name {
            name = n.first.capitalizingFirstLetter() + " " + n.last.capitalizingFirstLetter()
        }
        self.name.accept(name)
        self.phone.accept(user.phone)
        self.imageUrl.accept(URL(string: user.picture?.large ?? ""))
    }
    
    func isContentEqual(to source: UserViewModel) -> Bool {
        return differenceIdentifier == source.differenceIdentifier
    }
    
}

typealias UsersStore = Store<UsersState, Action>

extension UUID: Differentiable { }
