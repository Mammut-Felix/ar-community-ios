//
//  ShopView.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 04.02.22.
//

import Combine
import SwiftUI

struct ShopView: View {
    @EnvironmentObject var state: AppState
    @ObservedObject private var productListState = ProductListState()

    private var gridItemLayout = [GridItem(.flexible(), spacing: 16), GridItem(.flexible())]

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    var body: some View {
        NavigationView {
            ZStack {
                Group {
                    if productListState.products.count > 0 {
                        Color(uiColor: UIColor(named: "Primary")!)
                            .ignoresSafeArea()
                        ProductListView(products: self.productListState.products)
                            .environmentObject(state)
                    } else {
                        LoadingView(isLoading: self.productListState.isLoading, error: self.productListState.error) {
                            self.productListState.loadProducts()
                        }
                    }
                }
            }
            .onAppear {
                productListState.loadProducts()
            }
            .navigationTitle("Shop")
            .toolbar {
                CartBarItem()
                    .environmentObject(state)
            }
        }
    }
}

struct CartBarItem: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        NavigationLink(destination: EmptyView()) {
            Image(systemName: "cart")
                .foregroundColor(.white)
                .imageScale(.large)
                .overlay(
                    VStack {
                        if state.cartItems.cartProductDic.keys.count > 0 {
                            ZStack {
                                Circle().fill(Color(uiColor: UIColor(named: "AccentColor")!))
                                    .frame(width: 20, height: 20)
                                Text("\(state.cartItems.cartProductDic.keys.count)")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                    }.offset(x: 10, y: -10)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                )
        }.accentColor(.accentColor)
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ShopView()
                .environmentObject(AppState(user: nil))
                .previewDevice("iPhone 13 Pro")
        }
    }
}
