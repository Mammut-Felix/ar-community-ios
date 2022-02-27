//
//  Product+Stub.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 05.02.22.
//

import Foundation

extension Product {
    static var stubbedProducts: [Product] {
        let response: ProductResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "product_list")
        print(response)
        return response!
    }

    static var stubbedProduct: Product {
        stubbedProducts[0]
    }
}

extension Bundle {
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
