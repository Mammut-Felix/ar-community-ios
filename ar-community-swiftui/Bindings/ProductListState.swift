//
//  ProductListState.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 05.02.22.
//

import SwiftUI

class ProductListState: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var error: NSError?

    private let shopService: ShopService

    init(shopService: ShopService = ShopStore.shared) {
        self.shopService = shopService
    }

    func loadProducts() {
        products = []
        isLoading = true
        shopService.fetchProducts { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case let .success(response):
                self.products = response
            case let .failure(error):
                self.error = error as NSError
            }
        }
    }
}
