//
//  ProductDetailView.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 05.02.22.
//

import Combine
import RichText
import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var state: AppState
    let productId: Int
    @ObservedObject private var productDetailState = ProductDetailState()
    @ObservedObject var imageLoader = ImageLoader()

    var body: some View {
        ZStack {
            LoadingView(isLoading: self.productDetailState.isLoading, error: self.productDetailState.error) {
                self.productDetailState.loadProduct(id: self.productId)
            }

            if self.productDetailState.product != nil {
                VStack(alignment: .leading) {
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                Spacer()
                                ProductDetailImage(imageLoader: imageLoader, product: self.productDetailState.product!)
                                    .padding(.bottom, 32)
                                Spacer()
                            }
                            Text("Wähle eine Größe")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding(.horizontal, 16)
                                .lineLimit(1)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(self.productDetailState.product!.attributes.first?.options ?? [], id: \.self) { option in
                                        Button {
                                            self.productDetailState.selectedSize = option
                                        } label: {
                                            Text(option)
                                                .foregroundColor(.white)
                                                .fontWeight(.bold)
                                        }
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .background(self.productDetailState.selectedSize == option ? Color.accentColor : Color(red: 1, green: 1, blue: 1, opacity: 0.2))
                                        .cornerRadius(8)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            if let html = self.productDetailState.product?.productDescription {
                                RichText(html: html)
                                    .fontType(.system)
                                    .colorScheme(.dark)
                                    .colorImportant(true)
                                    .padding(.horizontal, 16)
                                    .padding(.top, 16)
                            }
                        }
                    }
                    Spacer()
                    HStack(alignment: .center) {
                        HStack(alignment: .bottom) {
                            Text("€")
                                .padding(.trailing, 0)
                                .padding(.leading, 16)
                                .foregroundColor(.accentColor)
                                .font(.headline)
                            Text(self.productDetailState.product!.price)
                                .padding(.leading, 0)
                                .padding(.trailing, 16)
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button {
                            if let product = productDetailState.product {
                                state.cartItems.addToCart(addedProduct: product, quantity: 1)
                            }

                        } label: {
                            Text("In den Warenkorb")
                                .foregroundColor(.white)
                        }
                        .padding(16)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                        .padding(.trailing, 16)
                    }
                }
            }
        }
        .navigationBarTitle(productDetailState.product?.name ?? "")
        .onAppear {
            self.productDetailState.loadProduct(id: self.productId)
        }
    }
}

struct ProductDetailImage: View {
    @ObservedObject var imageLoader: ImageLoader
    let product: Product

    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                VStack {
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                }
                .aspectRatio(0.7124183007, contentMode: .fit)
                .frame(minWidth: 100, maxWidth: 250)
            } else {
                VStack {
                    Image(uiImage: UIImage(named: "logo")!)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                }
                .aspectRatio(0.7124183007, contentMode: .fit)
                .frame(minWidth: 100, maxWidth: 250)
            }
        }
        .onAppear {
            if let url = URL(string: self.product.images.first?.src ?? "") {
                self.imageLoader.loadImage(with: url)
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            ProductDetailView(productId: Product.stubbedProduct.id)
                .environmentObject(AppState(user: nil))
                .previewDevice("iPhone 13 Pro")
        }
    }
}
