//
//  TwitchUserResponse.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 03.02.22.
//

import Foundation

// MARK: - TwitchUserResponse

struct TwitchUserResponse: Codable {
    let data: [TwitchUser]?

    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - Datum

struct TwitchUser: Codable {
    let id: String?
    let login: String?
    let displayName: String?
    let type: String?
    let broadcasterType: String?
    let datumDescription: String?
    let profileImageURL: String?
    let offlineImageURL: String?
    let viewCount: Int?
    let email: String?
    let createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case displayName = "display_name"
        case type
        case broadcasterType = "broadcaster_type"
        case datumDescription = "description"
        case profileImageURL = "profile_image_url"
        case offlineImageURL = "offline_image_url"
        case viewCount = "view_count"
        case email
        case createdAt = "created_at"
    }
}
