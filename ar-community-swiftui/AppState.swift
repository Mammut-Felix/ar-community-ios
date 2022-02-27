//
//  AppState.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 03.02.22.
//

import Combine
import SwiftUI

class AppState: ObservableObject {
    var loginPublisher = PassthroughSubject<User, Error>()
    var logoutPublisher = PassthroughSubject<Void, Error>()
    let userPublisher = PassthroughSubject<User, Error>()
    var cancellables = Set<AnyCancellable>()

    @Published var cartItems = CartViewModel()

    @Published var shouldIndicateActivity = false
    @Published var error: String?
    @Published var notifications: Bool

    var user: User?

    var loggedIn: Bool {
        User.current != nil && user != nil
    }

    init(user: User?) {
        self.user = user
        notifications = true
        loginPublisher
            .receive(on: DispatchQueue.main)
            .map {
                self.shouldIndicateActivity = false
                return $0
            }
            .subscribe(userPublisher)
            .store(in: &cancellables)

        userPublisher
            .sink(receiveCompletion: { result in
                if case let .failure(error) = result {
                    self.error = "Failed to log in: \(error.localizedDescription)"
                }
            }, receiveValue: { user in
                print(user)
                self.user = user
            })
            .store(in: &cancellables)

        logoutPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { _ in
                self.user = nil
            })
            .store(in: &cancellables)
    }
}
