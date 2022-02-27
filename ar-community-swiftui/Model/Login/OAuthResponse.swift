//
//  OAuthResponse.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 03.02.22.
//

import Foundation

struct OAuthResponse: Codable {
    let accessToken: String
    let expiresIn: Int
    let idToken: String
    let refreshToken: String
    let scope: [String]
    let tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case idToken = "id_token"
        case refreshToken = "refresh_token"
        case scope
        case tokenType = "token_type"
    }
}
