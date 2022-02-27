//
//  ShopOfflineView.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 23.02.22.
//

import SwiftUI

struct ShopOfflineView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(uiColor: UIColor(named: "Primary")!)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("shop")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 64.0)
                        .padding(.bottom, 32)
                    Text("Unser Shop ist aktuell offline, versuche es später nocheinmal...")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16.0)
                    Spacer()
                }
            }
            .navigationTitle("Shop")
        }
    }
}

struct ShopOfflineView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ShopOfflineView()
                .previewDevice("iPhone 13 Pro")
        }
    }
}
