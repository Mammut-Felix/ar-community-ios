//
//  ShopService.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 05.02.22.
//

import Foundation

protocol ShopService {
    func fetchProducts(completion: @escaping (Result<ProductResponse, ShopError>) -> Void)
    func fetchProduct(id: Int, completion: @escaping (Result<Product, ShopError>) -> Void)
}

enum ShopListEndpoint: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    case products
}

enum ShopError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError

    var localizedDescription: String {
        switch self {
        case .apiError: return "Beim Herunterladen der Daten ist ein Fehler aufgetaucht."
        case .invalidEndpoint: return "Ungültiger Endpunkt"
        case .invalidResponse: return "Beim Herunterladen der Daten ist ein Fehler aufgetaucht."
        case .noData: return "Beim Herunterladen der Daten ist ein Fehler aufgetaucht."
        case .serializationError: return "Beim Herunterladen der Daten ist ein Fehler aufgetaucht."
        }
    }

    var errorUserInfo: [String: Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
