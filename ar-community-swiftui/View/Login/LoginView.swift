//
//  LoginView.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 02.02.22.
//

import AuthenticationServices
import Combine
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var state: AppState

    @State var username: String = ""
    @State var password: String = ""
    @State var cancellables: Set<AnyCancellable> = []
    var body: some View {
        NavigationView {
            ZStack {
                Group {
                    AnimatedBackgroundView(fileName: "LoginBackground")
                        .ignoresSafeArea()
                    Color(uiColor: .init(red: 0, green: 0, blue: 0, alpha: 0.4))
                        .ignoresSafeArea()
                }
                VStack(alignment: .leading, spacing: 0) {
                    Group {
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    Group {
                        Text("Benutzername")
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                            .padding(.bottom, 0)
                        TextField("", text: $username)
                            .padding(.vertical, 8)
                            .padding(.leading, 0)
                            .padding(.bottom, 0)
                            .padding(.horizontal, 32)
                            .foregroundColor(.white)
                        Color.white.frame(height: CGFloat(3) / UIScreen.main.scale)
                            .padding(.top, 0)
                            .padding(.horizontal, 32)
                            .padding(.bottom, 32)
                        Text("Passwort")
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                            .padding(.bottom, 0)
                        SecureField("", text: $password)
                            .padding(.vertical, 8)
                            .padding(.leading, 0)
                            .padding(.bottom, 0)
                            .padding(.horizontal, 32)
                            .foregroundColor(.white)
                        Color.white.frame(height: CGFloat(3) / UIScreen.main.scale)
                            .padding(.top, 0)
                            .padding(.horizontal, 32)
                            .padding(.bottom, 8)
                    }
                    HStack {
                        Spacer()
                        Button("Passwort vergessen?") {
                        }
                        .tint(.white)
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 64)
                    HStack(alignment: .center) {
                        Spacer()
                        Button {
                            login()
                        } label: {
                            Text("Login").foregroundColor(Color.white)
                        }
                        .frame(width: 250, height: 40, alignment: .center)
                        .background(Color.accentColor)
                        .cornerRadius(.infinity)

                        Spacer()
                    }
                    .padding(.bottom, 16)
//                HStack(alignment: .center) {
//                    Spacer()
//                    Button {
//                        loginWithTwitch()
//                    } label: {
//                        Image("twitch-icon", bundle: .main)
//                            .resizable()
//                            .frame(width: 15, height: 15, alignment: .center)
//                            .tint(.white)
//                            .padding(.trailing, 6)
//                        Text("Login mit Twitch").foregroundColor(Color.white)
//                    }
//                    .frame(width: 250, height: 40, alignment: .center)
//                    .background(Color(red: 100 / 255, green: 65 / 255, blue: 165 / 255))
//                    .cornerRadius(.infinity)
//                    Spacer()
//                }
//                .padding(.bottom, 16)
//                HStack(alignment: .center) {
//                    Spacer()
//                    SignInWithAppleButton(.signIn) { request in
//                        request.requestedScopes = [.fullName, .email]
//                    } onCompletion: { result in
//                        switch result {
//                        case let .success(authResults):
//                            print("Authorisation successful")
//                        case let .failure(error):
//                            print("Authorisation failed: \(error.localizedDescription)")
//                        }
//                    }
//                    .frame(width: 250, height: 40, alignment: .center)
//                    .cornerRadius(.infinity)
//                    .padding(.horizontal, 64)
//                    Spacer()
//                }
                    Group {
                        Spacer()
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("Du hast keinen Account?")
                            .foregroundColor(.white)
                        NavigationLink(destination: RegisterView()) {
                            Text("Registrieren")
                                .foregroundColor(Color(uiColor: UIColor(named: "AccentColor")!))
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        
    }

    func login() {
        User.loginPublisher(username: username, password: password)
            .sink { subscriber in
                state.shouldIndicateActivity = false
                switch subscriber {
                case .finished:
                    break
                case let .failure(error):
                    self.state.error = error.localizedDescription
                }
            } receiveValue: { user in
                state.loginPublisher.send(user)
            }
            .store(in: &cancellables)
    }

    func loginWithTwitch() {
        TwitchAuthManager.shared.authenticate()
            .sink { subscriber in
                state.shouldIndicateActivity = false
                switch subscriber {
                case .finished:
                    break
                case let .failure(error):
                    self.state.error = error.localizedDescription
                }
            } receiveValue: { user in
                state.loginPublisher.send(user)
            }
            .store(in: &cancellables)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .previewDevice("iPhone 13 Pro")
        }
    }
}
