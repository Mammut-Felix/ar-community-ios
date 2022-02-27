//
//  TwitchAuthManager.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 03.02.22.
//

import AuthenticationServices
import Combine
import Foundation
import ParseSwift

struct TwitchAuthResponse: Codable {
    let authToken: String?
    let accessToken: String?
    let userId: String?
    let username: String?
    let email: String?
    let profileImage: String?
}

final class TwitchAuthManager: NSObject {
    static let shared = TwitchAuthManager()

    private(set) var authToken = ""
    private(set) var accessToken = ""

    private var cancellables: Set<AnyCancellable> = []

    override fileprivate init() {
        super.init()
    }

    func authenticate() -> AnyPublisher<User, Error> {
        return Future<User, Error> { promise in
            self.authorizePublisher(context: self)
                .sink { subscription in
                    switch subscription {
                    case let .failure(error):
                        promise(.failure(error))
                    case .finished:
                        break
                    }
                } receiveValue: { token in
                    self.accessTokenPublisher(authToken: token)
                        .sink { subscription in
                            switch subscription {
                            case let .failure(error):
                                promise(.failure(error))
                            case .finished:
                                break
                            }
                        } receiveValue: { response in
                            self.accessToken = response.accessToken
                            self.userDetailsPublisher(token: response.accessToken)
                                .sink { subscription in
                                    switch subscription {
                                    case let .failure(error):
                                        promise(.failure(error))
                                    case .finished:
                                        break
                                    }
                                } receiveValue: { userResponse in
                                    let twitchUser = userResponse.data?.first

                                    User.loginPublisher("twitch", authData: ["id": twitchUser?.id ?? "", "access_token": response.accessToken, "refresh_token": response.refreshToken, "auth_token": token])
                                        .sink { subscription in
                                            switch subscription {
                                            case let .failure(error):
                                                promise(.failure(error))
                                            case .finished:
                                                break
                                            }
                                        } receiveValue: { user in
                                            var user = user
                                            user.email = twitchUser?.email
                                            user.username = twitchUser?.displayName
                                            user.emailVerified = true
                                            user.description = twitchUser?.datumDescription
                                            user.twitchId = twitchUser?.id
                                            if let imageUrl = URL(string: twitchUser?.profileImageURL ?? "") {
                                                print("set profileImage")
                                                var file = ParseFile(cloudURL: imageUrl)
                                                file.mimeType = "image/png"
                                                user.profileImage = file
                                            }
                                            user.savePublisher()
                                                .sink { subscription in
                                                    switch subscription {
                                                    case let .failure(error):
                                                        promise(.failure(error))
                                                    case .finished:
                                                        break
                                                    }
                                                } receiveValue: { finalUser in
                                                    promise(.success(finalUser))
                                                }
                                                .store(in: &self.cancellables)
                                        }
                                        .store(in: &self.cancellables)
                                }
                                .store(in: &self.cancellables)
                        }
                        .store(in: &self.cancellables)
                }
                .store(in: &self.cancellables)
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }

    func authorizePublisher(context: ASWebAuthenticationPresentationContextProviding) -> AnyPublisher<String, Error> {
        let authorizeEndpoint = "https://id.twitch.tv/oauth2/authorize?client_id=\(Constants.twitchClientId)&redirect_uri=https://arcommunity.mammut-hosting.de/api/v1/oauth/redirect&response_type=code&scope=user:read:email+user:read:subscriptions+openid&claims={%22id_token%22:{%22email%22:null},%22userinfo%22:{%22picture%22:null}}".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let authorizeURL = URL(string: authorizeEndpoint)!

        return Future<String, Error> { promise in
            let session = ASWebAuthenticationSession(url: authorizeURL, callbackURLScheme: Constants.scheme) { callbackURL, error in
                if let error = error {
                    promise(.failure(error))
                }
                if let callbackURL = callbackURL {
                    let components = URLComponents(url: callbackURL, resolvingAgainstBaseURL: true)
                    if let token = components?.queryItems?[0].value {
                        self.authToken = token
                        promise(.success(token))
                    }
                }
            }
            session.presentationContextProvider = context
            session.start()
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }

    private func accessTokenPublisher(authToken: String) -> AnyPublisher<OAuthResponse, Error> {
        let tokenEndpoint = "https://id.twitch.tv/oauth2/token?client_id=\(Constants.twitchClientId)&client_secret=zade5q8znojgp13201zuy4skfr4bcc&grant_type=authorization_code&redirect_uri=https://arcommunity.mammut-hosting.de/api/v1/token&code=\(authToken)"

        let tokenUrl = URL(string: tokenEndpoint)!
        var urlRequest = URLRequest(url: tokenUrl)
        urlRequest.httpMethod = "POST"

        return URLSession.DataTaskPublisher(request: urlRequest, session: .shared)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .receive(on: RunLoop.main)
            .decode(type: OAuthResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    private func userDetailsPublisher(token: String) -> AnyPublisher<TwitchUserResponse, Error> {
        let userEndpoint = "https://api.twitch.tv/helix/users"
        let userEndpointUrl = URL(string: userEndpoint)!
        var urlRequest = URLRequest(url: userEndpointUrl)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("6ohbd6l6mnroen3p3ldg1nd51b4f3z", forHTTPHeaderField: "Client-Id")

        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601

        return URLSession.DataTaskPublisher(request: urlRequest, session: .shared)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .receive(on: RunLoop.main)
            .decode(type: TwitchUserResponse.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}

extension TwitchAuthManager: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession)
        -> ASPresentationAnchor {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window ?? ASPresentationAnchor()
    }
}
