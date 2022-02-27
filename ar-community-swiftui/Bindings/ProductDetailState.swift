//
//  ProductDetailState.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 05.02.22.
//

import SwiftUI

class ProductDetailState: ObservableObject {
    private let shopService: ShopService
    @Published var product: Product?
    @Published var selectedSize: String = ""
    @Published var isLoading = false
    @Published var error: NSError?

    init(shopService: ShopService = ShopStore.shared) {
        self.shopService = shopService
    }

    func loadProduct(id: Int) {
        product = nil
        isLoading = true
        shopService.fetchProduct(id: id) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case let .success(product):
                self.product = product
                self.selectedSize = product.defaultAttributes.first?.option ?? ""
                print(self.selectedSize)
            case let .failure(error):
                self.error = error as NSError
            }
        }
    }
}
