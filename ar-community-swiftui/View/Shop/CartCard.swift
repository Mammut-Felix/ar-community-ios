//
//  CartCard.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 24.02.22.
//

import SwiftUI

struct CartCard: View {
    @ObservedObject var imageLoader = ImageLoader()

    var product: Product

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack {
                    Spacer()
                    ProductDetailImage(imageLoader: imageLoader, product: self.product)
                        .padding(22)
                    Spacer()
                }
                .aspectRatio(0.7124183007, contentMode: .fit)
                .background(Color(red: 1, green: 1, blue: 1, opacity: 0.2))
                .cornerRadius(20)
                .padding(.trailing, 16)
                VStack(alignment: .leading) {
                    Text(product.name)
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(.bottom, 8)
                    Text("Size: M")
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                    HStack(alignment: .bottom) {
                        Text("€")
                            .foregroundColor(.accentColor)
                        Text("99,99")
                            .foregroundColor(.white)
                            .font(.title3)
                    }
                    HStack {
                        Button {
                        } label: {
                            Text("-")
                                .foregroundColor(.white)
                                .font(.title3)
                                .frame(width: 20, height: 20)
                        }
                        .background(Color.accentColor)
                        .cornerRadius(5)
                        Text("1")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                        Button {
                        } label: {
                            Text("+")
                                .foregroundColor(.white)
                                .font(.title3)
                                .frame(width: 20, height: 20)
                        }
                        .background(Color.accentColor)
                        .cornerRadius(5)
                    }
                }
            }
        }
    }
}

struct CartCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            CartCard(product: Product.stubbedProduct)
        }
    }
}
