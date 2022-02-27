//
//  User.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 03.02.22.
//

import Foundation
import ParseSwift

struct User: ParseUser {
    var originalData: Data?
    var username: String?
    var email: String?
    var emailVerified: Bool?
    var password: String?
    var authData: [String: [String: String]?]?
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var invitedBy: String?
    var inviteCode: String?
    var description: String?
    var twitchId: String?
    var userStatus: String?
    var profileImage: ParseFile?
    var vipPoints: Int?
    var coins: Int?
    var profileImageUrl: URL {
        if let profileImage = profileImage, let url = profileImage.url {
            return url
        } else {
            if let md5 = email?.md5, let url = URL(string: "https://www.gravatar.com/avatar/\(md5)?d=robohash&r=g&s=500") {
                return url
            }
        }

        return URL(string: "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=robohash&r=g&s=500")!
    }
}
