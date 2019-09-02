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
import RxRealm
import RealmSwift

struct UserViewModel: Differentiable {

    typealias DifferenceIdentifier = UUID
    var differenceIdentifier: UUID = UUID()

    var name: BehaviorRelay<String>
    var phone: BehaviorRelay<String>
    var imageUrl: BehaviorRelay<URL?>
    
    let user: User
    
    init(user: User) {
        self.user = user
        var name = ""
        if let n = user.name {
            name = n.first.capitalizingFirstLetter() + " " + n.last.capitalizingFirstLetter()
        }
        self.name = BehaviorRelay(value: name)
        self.phone = BehaviorRelay(value: user.phone)
        self.imageUrl = BehaviorRelay(value: URL(string: user.picture?.large ?? ""))
    }
    
    func update() {
        self.name.accept(user.name?.formattedName ?? "")
        self.phone.accept(user.phone)
        self.imageUrl.accept(URL(string: user.picture?.large ?? ""))
    }
    
    func isContentEqual(to source: UserViewModel) -> Bool {
        return differenceIdentifier == source.differenceIdentifier
    }
    
}

extension ObservableType where Element == [User] {
    func toUserViewModels() -> Observable<[UserViewModel]> {
        return self.map({ $0.compactMap({ UserViewModel(user: $0) }) })
    }
}

extension ObservableType where Element == (AnyRealmCollection<User>, RealmChangeset?) {

    func toUserViewModelsWithChanges() -> Observable<([UserViewModel], RealmChangeset?)> {
        return self.map({ (results, changes) -> ([UserViewModel], RealmChangeset?) in
            return (results.compactMap({ UserViewModel(user: $0) }), changes)
        })
    }

}

extension Observable where Element == ([UserViewModel], RealmChangeset?) {
    
    func updateState() -> Observable<Action> {
        return self.map { (arg) -> Action in
            let (viewModels, changes) = arg
            if let changes = changes {
                return Action.realmUpdates(viewModels: viewModels, deleted: changes.deleted, added: changes.inserted, updated: changes.updated)
            } else {
                return Action.realmUpdates(viewModels: [], deleted: [], added: [], updated: [])
            }
        }
    }
    
}
