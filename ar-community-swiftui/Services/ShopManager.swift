//
//  ShopManager.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 04.02.22.
//

import Combine
import Foundation

enum ShopEndpoint: String {
    case product = "/wp-json/wc/v3/products/"
}

final class ShopManager {
    var chartItems: [Product] = []

    func request(method: String = "GET", endpoint: ShopEndpoint, id: String? = nil, body: String? = nil) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        var login = "\(Constants.shopUsername):\(Constants.shopPassword)"
        let base64LoginString = login.data(using: .utf8)?.base64EncodedString()
        var path = "\(Constants.shopBaseUrl)\(endpoint.rawValue)"

        if let id = id {
            path += id
        }

        let url = URL(string: path)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("Basic \(base64LoginString ?? "")", forHTTPHeaderField: "Authorization")

        if let body = body {
            request.httpBody = body.data(using: .utf8)
        }

        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .eraseToAnyPublisher()
    }
}
