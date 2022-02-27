//
//  AppleLoginButton.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 03.02.22.
//

import AuthenticationServices
import SwiftUI

struct AppleLoginButton: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton

    var type: ASAuthorizationAppleIDButton.ButtonType = .signIn
    var style: ASAuthorizationAppleIDButton.Style = .black

    func makeUIView(context: Context) -> UIViewType {
        return ASAuthorizationAppleIDButton(type: type, style: style)
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
