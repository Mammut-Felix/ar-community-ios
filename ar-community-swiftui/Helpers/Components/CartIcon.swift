//
//  CartIcon.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 23.02.22.
//

import SwiftUI

struct CartIcon: View {
    var count: Int

    var body: some View {
        Image("cart")
        ZStack {
            Circle()
            if count > 0 {
                Text("\(count)")
                    .foregroundColor(.white)
                    .font(.caption)
            } else {
                Text("")
            }
        }
        .offset(x: -15, y: -10)
        .frame(width: 20, height: 20)
    }
}
