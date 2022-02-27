//
//  ActivityIndicatorView.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 05.02.22.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.color = UIColor(named: "AccentColor")
        view.startAnimating()
        return view
    }
}
