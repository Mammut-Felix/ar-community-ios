//
//  CartView.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 24.02.22.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var state: AppState
    var body: some View {
        ZStack {
            Color(uiColor: UIColor(named: "Primary")!)
                .ignoresSafeArea()
            VStack {
                ForEach(Product.stubbedProducts) { product in
                    CartCard(product: product)
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(AppState(user: nil))
    }
}
