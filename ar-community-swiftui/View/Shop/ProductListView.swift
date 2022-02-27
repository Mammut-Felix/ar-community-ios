//
//  ProductListView.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 05.02.22.
//

import SwiftUI

struct ProductListView: View {
    @EnvironmentObject var state: AppState
    let products: [Product]

    var body: some View {
        ScrollView {
            HStack(alignment: .top, spacing: 16) {
                ForEach(self.products) { product in
                    NavigationLink(destination: ProductDetailView(productId: product.id).environmentObject(state)) {
                        ProductCard(product: product)
                    }
                    .padding(.leading, product.id == self.products.first!.id ? 16 : 0)
                    .padding(.trailing, product.id == self.products.last!.id ? 16 : 0)
                    .padding(.top, product.id == self.products.first!.id ? 32 : 0)
                    .padding(.top, product.id == self.products.last!.id ? 32 : 0)
                }
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(uiColor: UIColor(named: "Primary")!)
                .ignoresSafeArea()
            ProductListView(products: Product.stubbedProducts)
                .environmentObject(AppState(user: nil))
        }
    }
}
