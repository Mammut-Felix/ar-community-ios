//
//  ProductCard.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 05.02.22.
//

import SwiftUI

struct ProductCard: View {
    let product: Product
    @ObservedObject var imageLoader = ImageLoader()

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                if self.imageLoader.image != nil {
                    VStack {
                        Spacer()
                        Image(uiImage: self.imageLoader.image!)
                            .resizable()
                            .scaledToFit()
                            .padding(22)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .aspectRatio(0.7124183007, contentMode: .fit)
                    .background(Color(red: 1, green: 1, blue: 1, opacity: 0.2))
                    .cornerRadius(20)
                } else {
                    VStack {
                        Spacer()
                        Image(uiImage: UIImage(named: "logo")!)
                            .resizable()
                            .scaledToFit()
                            .padding(22)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .aspectRatio(0.7124183007, contentMode: .fit)
                    .background(Color(red: 1, green: 1, blue: 1, opacity: 0.2))
                    .cornerRadius(20)
                }
                Text(product.name)
                    .font(.footnote)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 10)
                    .padding(.top, 8)
                    .lineLimit(2)
                Text(product.price)
                    .foregroundColor(.init(red: 1, green: 1, blue: 1, opacity: 0.5))
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.top, 4)
                    .lineLimit(1)
            }
        }
        .onAppear {
            self.imageLoader.loadImage(with: URL(string: self.product.images[0].src)!)
        }
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(uiColor: UIColor(named: "Primary")!)
                .ignoresSafeArea()
            ProductCard(product: Product.stubbedProduct)
        }
    }
}
