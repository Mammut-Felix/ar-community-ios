//
//  ProfileView.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 05.02.22.
//

import Combine
import ParseSwift
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var state: AppState
    @ObservedObject var imageLoader = ImageLoader()

    @State var cancellables: Set<AnyCancellable> = []
    @State var isOn: Bool = false

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(uiColor: UIColor(named: "Primary")!)
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    HStack(spacing: 32) {
                        Spacer()
                        if self.imageLoader.image != nil {
                            Image(uiImage: self.imageLoader.image!)
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                .scaledToFit()
                        } else {
                            Image(uiImage: UIImage(named: "logo")!)
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .clipShape(Circle())
                                .scaledToFit()
                                .foregroundColor(.white)
                        }
                        VStack(alignment: .leading) {
                            Text(state.user?.username ?? "")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding(.bottom, 2)
                            Text(state.user?.userStatus ?? "")
                                .foregroundColor(.white)
                                .font(.caption)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 16)
                    HStack {
                        Spacer()
                        Text("- VIP 1 -")
                            .foregroundColor(.accentColor)
                            .font(.headline)
                        Spacer()
                    }
                    List {
                        Text("Meine Coins")
                            .badge("\(state.user?.coins ?? 0)")
                            .foregroundColor(.white)
                            .listRowBackground(Color(uiColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)))
                        Toggle(isOn: $isOn) {
                            Text("Benachrichtigungen")
                                .foregroundColor(.white)
                        }
                        .tint(.accentColor)
                        .listRowBackground(Color(uiColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)))
                        HStack {
                            Spacer()
                            Text("Logout")
                                .foregroundColor(.red)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .onTapGesture {
                            logout()
                        }
                        .listRowBackground(Color(uiColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)))
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Dabei seit 01.01.2000")
                            .foregroundColor(.accentColor)
                            .font(.caption)
                        Spacer()
                    }
                }
                .padding(.top, 32)
                .padding(.horizontal, 16)
            }
            .navigationTitle("Profil")
            .onAppear {
                if let url = state.user?.profileImageUrl {
                    imageLoader.loadImage(with: url)
                }
            }
        }
    }

    func logout() {
        state.shouldIndicateActivity = true
        User.logoutPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: {
                state.shouldIndicateActivity = false
                state.logoutPublisher.send($0)
            })
            .store(in: &state.cancellables)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileView()
                .environmentObject(AppState(user: User(originalData: nil, username: "mrwindelde", email: "test@test.de", emailVerified: true, password: nil, authData: nil, objectId: nil, createdAt: Date(), updatedAt: nil, ACL: nil, invitedBy: nil, inviteCode: nil, description: nil, twitchId: "1234", userStatus: "Subscriber Tier 1", profileImage: nil, vipPoints: 10423, coins: 2345)))
                .previewDevice("iPhone 13 Pro")
        }
    }
}
