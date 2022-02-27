//
//  AnimatedBackgroundView.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 02.02.22.
//

import SwiftUI
import SwiftyGif

struct AnimatedBackgroundView: UIViewRepresentable {
    typealias UIViewType = UIView

    var fileName: String

    func makeUIView(context: Context) -> UIView {
        let view = UIView()

        let path = Bundle.main.path(forResource: fileName, ofType: "gif")!
        let url = URL(fileURLWithPath: path)
        let gifData = try! Data(contentsOf: url)

        let gif = try! UIImage(gifData: gifData)
        let imageView = UIImageView(gifImage: gif, loopCount: -1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<AnimatedBackgroundView>) {
    }
}
