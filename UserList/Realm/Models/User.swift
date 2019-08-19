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
    dynamic var name: Name?
    dynamic var email: String = ""
    dynamic var phone: String = ""
    dynamic var picture: Picture?
    
    enum CodingKeys: String, CodingKey {
        case gender
        case name
        case email
        case phone
        case picture
    }
    
}

extension User {
    
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
    
    func save() {
        guard realm == nil else { return }
        DispatchQueue(label: "background.realm").async {
            autoreleasepool {
                let realm = RealmProvider.users.realm
                do {
                    try realm.write {
                        realm.add(self)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    static func loadUsers() -> [User] {
        let users = RealmProvider.users.realm.objects(User.self)
        var result: [User] = []
        users.forEach { result.append($0) }
        return result
    }
    
}
