//
//  LoadingView.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 05.02.22.
//

import SwiftUI

struct LoadingView: View {
    let isLoading: Bool
    let error: NSError?
    let retryAction: (() -> Void)?

    var body: some View {
        ZStack {
            Color(uiColor: UIColor(named: "Primary")!)
                .ignoresSafeArea()
        Group {
            if isLoading {
                HStack {
                    Spacer()
                    ActivityIndicatorView()
                    Spacer()
                }
            } else if error != nil {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Text(error!.localizedDescription).font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 16)
                        if self.retryAction != nil {
                            Button(action: self.retryAction!) {
                                Text("Nochmal versuchen")
                                    .padding(10)
                                    .foregroundColor(.white)
                                    .background(Color.accentColor)
                                    .cornerRadius(5)
                                    
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    Spacer()
                }
            }
        }
    }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
//        LoadingView(isLoading: true, error: nil, retryAction: nil)
        LoadingView(isLoading: false, error: ShopError.invalidResponse as NSError) {
            
        }
    }
}
