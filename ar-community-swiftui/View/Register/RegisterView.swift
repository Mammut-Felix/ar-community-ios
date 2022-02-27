//
//  RegisterView.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 25.02.22.
//

import Combine
import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var state: AppState

    @State var username: String = ""
    @State var password: String = ""
    @State var email: String = ""
    @State var inviteCode: String = ""
    @State var cancellables: Set<AnyCancellable> = []

    var body: some View {
        ZStack {
            Group {
                AnimatedBackgroundView(fileName: "LoginBackground")
                    .ignoresSafeArea()
                Color(uiColor: .init(red: 0, green: 0, blue: 0, alpha: 0.4))
                    .ignoresSafeArea()
            }
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    Text("Benutzername")
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 0)
                    TextField("", text: $username)
                        .textContentType(.username)
                        .padding(.vertical, 8)
                        .padding(.leading, 0)
                        .padding(.bottom, 0)
                        .padding(.horizontal, 32)
                        .foregroundColor(.white)
                    Color.white.frame(height: CGFloat(3) / UIScreen.main.scale)
                        .padding(.top, 0)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 32)
                }
                Group {
                    Text("E-Mailadresse")
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 0)
                    TextField("", text: $email)
                        .textContentType(.emailAddress)
                        .padding(.vertical, 8)
                        .padding(.leading, 0)
                        .padding(.bottom, 0)
                        .padding(.horizontal, 32)
                        .foregroundColor(.white)
                    Color.white.frame(height: CGFloat(3) / UIScreen.main.scale)
                        .padding(.top, 0)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 32)
                }
                Group {
                    Text("Passwort")
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 0)
                    SecureField("", text: $password)
                        .textContentType(.newPassword)
                        .padding(.vertical, 8)
                        .padding(.leading, 0)
                        .padding(.bottom, 0)
                        .padding(.horizontal, 32)
                        .foregroundColor(.white)
                    Color.white.frame(height: CGFloat(3) / UIScreen.main.scale)
                        .padding(.top, 0)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 32)
                }
                Group {
                    Text("Einladungcode")
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 0)
                    TextField("", text: $inviteCode)
                        .textContentType(.oneTimeCode)
                        .padding(.vertical, 8)
                        .padding(.leading, 0)
                        .padding(.bottom, 0)
                        .padding(.horizontal, 32)
                        .foregroundColor(.white)
                    Color.white.frame(height: CGFloat(3) / UIScreen.main.scale)
                        .padding(.top, 0)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 64)
                }
                HStack(alignment: .center) {
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Registrieren").foregroundColor(Color.white)
                    }
                    .frame(width: 250, height: 40, alignment: .center)
                    .background(Color.accentColor)
                    .cornerRadius(.infinity)

                    Spacer()
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
