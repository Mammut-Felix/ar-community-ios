//
//  CartState.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 23.02.22.
//

import SwiftUI

class CartState: ObservableObject {
    @Published var cartItems: [Product] = []
}
