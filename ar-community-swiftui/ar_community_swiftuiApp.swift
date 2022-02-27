//
//  ar_community_swiftuiApp.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 02.02.22.
//

import ParseSwift
import SwiftUI

@main
struct ar_community_swiftuiApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @StateObject var state = AppState(user: User.current)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(state)
        }
    }

    init() {
        let config = ParseConfiguration(applicationId: "ar-community",
                                        clientKey: "Vt95m7U8fx2n2pAXCBhNk3b2ncB5DKyC",
                                        serverURL: URL(string: "https://arcommunity.mammut-hosting.de/api/v1/parse")!,
                                        keyValueStore: KeyValueStore(),
                                        cacheDiskCapacity: 100000000
        )
        ParseSwift.initialize(configuration: config)
    }
}
