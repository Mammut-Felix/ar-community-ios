//
//  Tabview.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 04.02.22.
//

import SwiftUI

struct Tabview: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        TabView {
            Text("Home")
                .tabItem {
                    Image("home")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                    Text("Home")
                }
            ShopView()
                .environmentObject(state)
                .tabItem {
                    Image("cart")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                    Text("Shop")
                }
            Text("Tickets")
                .tabItem {
                    Image("ticket")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                    Text("Tickets")
                }
            ProfileView()
                .environmentObject(state)
                .tabItem {
                    Image("user")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                    Text("Profil")
                }
        }
        .onAppear {
            print(state.user)
        }
    }
}

struct Tabview_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Tabview()
                .previewDevice("iPhone 13 Pro")
        }
    }
}
