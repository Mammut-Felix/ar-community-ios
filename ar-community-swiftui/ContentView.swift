//
//  ContentView.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 02.02.22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        ZStack {
            if state.loggedIn {
                Tabview()
                    .environmentObject(state)
            } else {
                LoginView()
                    .environmentObject(state)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState(user: nil))
    }
}
