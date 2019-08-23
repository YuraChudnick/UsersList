//
//  User.swift
//  UserList
//
//  Created by Yurii Chudnovets on 6/14/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RealmSwift

enum AvatarSize {
    case large
    case medium
    case thumbnail
}

enum UserDataError: Error {
    case noLargeURL
    case noMediumURL
    case noThumbnailURL
}

@objcMembers class User: Object, Codable {
    
    dynamic var gender: String = ""
    dynamic var name: Name? = nil
    dynamic var email: String = ""
    dynamic var phone: String = ""
    dynamic var picture: Picture? = nil
    
    enum CodingKeys: String, CodingKey {
        case gender
        case name
        case email
        case phone
        case picture
    }
    
}

extension User {
    
    func fill(with newValues: (first: String, last: String, email: String, phone: String, image: String)) {
        self.name?.first        = newValues.first
        self.name?.last         = newValues.last
        self.email              = newValues.email
        self.phone              = newValues.phone
        self.picture?.large     = newValues.image
        self.picture?.medium    = newValues.image
        self.picture?.thumbnail = newValues.image
    }
    
    func getAvatarUrl(_ avatarSize: AvatarSize) throws -> URL {
        switch avatarSize {
        case .large:
            guard let large = picture?.large, let url = URL(string: large) else {
                throw UserDataError.noLargeURL
            }
            return url
        case .medium:
            guard let medium = picture?.medium, let url = URL(string: medium) else {
                throw UserDataError.noMediumURL
            }
            return url
        case .thumbnail:
            guard let thumbnail = picture?.thumbnail, let url = URL(string: thumbnail) else {
                throw UserDataError.noThumbnailURL
            }
            return url
        }
    }
    
    func getAvatarKey(_ avatarSize: AvatarSize) -> String {
        switch avatarSize {
        case .large:
            return picture?.large ?? ""
        case .medium:
            return picture?.medium ?? ""
        case .thumbnail:
            return picture?.thumbnail ?? ""
        }
    }
    
    func update(in realmProvider: RealmProvider = RealmProvider.users, with newValues: (first: String, last: String, email: String, phone: String, image: String)) {
        let realm = realmProvider.realm
        do {
            try realm.write {
                fill(with: newValues)
            }
        } catch {
            print(error)
        }
    }
    
    func save(in realmProvider: RealmProvider = RealmProvider.users) {
        guard realm == nil else { return }
        let realm = realmProvider.realm
        do {
            try realm.write {
                realm.add(self)
            }
        } catch {
            print(error)
        }
    }
    
    static func loadUsers() -> [User] {
        let users = RealmProvider.users.realm.objects(User.self)
        var result: [User] = []
        users.forEach { result.append($0) }
        return result
    }
    
}
