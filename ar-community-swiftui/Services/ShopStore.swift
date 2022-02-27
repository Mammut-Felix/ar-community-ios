//
//  ShopStore.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 05.02.22.
//

import Foundation

class ShopStore: ShopService {
    static let shared = ShopStore()
    private init() {}

    private let username = "ck_e17581204f9011faa48cb5446282749159951a21"
    private let password = "cs_28cbaefe7f6ed9acdbbc67afa46d9d4992f3879d"
    private let baseAPIURL = "https://work349585.mammut-hosting.de"
    private let urlSession = URLSession.shared
    private let jsonDecoder = JSONDecoder()
    private var base64LoginString: String? {
        let login = "\(username):\(password)"
        return login.data(using: .utf8)?.base64EncodedString()
    }

    func fetchProducts(completion: @escaping (Result<ProductResponse, ShopError>) -> Void) {
        guard let url = URL(string: "\(baseAPIURL)/wp-json/wc/v3/products/") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        loadURLAndDecode(url: url, completion: completion)
    }

    func fetchProduct(id: Int, completion: @escaping (Result<Product, ShopError>) -> Void) {
        guard let url = URL(string: "\(baseAPIURL)/wp-json/wc/v3/products/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        loadURLAndDecode(url: url, completion: completion)
    }

    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, ShopError>) -> Void) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }

        var queryItems: [URLQueryItem] = []
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }

        urlComponents.queryItems = queryItems

        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }

        var request = URLRequest(url: finalURL)
        request.setValue("Basic \(base64LoginString ?? "")", forHTTPHeaderField: "Authorization")
//        request.cachePolicy = .reloadRevalidatingCacheData

        urlSession.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, 200 ..< 300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }

            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }

            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }

    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, ShopError>, completion: @escaping (Result<D, ShopError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
