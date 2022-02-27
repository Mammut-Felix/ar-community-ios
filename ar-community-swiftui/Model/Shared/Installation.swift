//
//  Installation.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 23.02.22.
//

import Foundation
import ParseSwift

struct Installation: ParseInstallation {
    var deviceType: String?
    var installationId: String?
    var deviceToken: String?
    var badge: Int?
    var timeZone: String?
    var channels: [String]?
    var appName: String?
    var appIdentifier: String?
    var appVersion: String?
    var parseVersion: String?
    var localeIdentifier: String?
    var originalData: Data?
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
}
