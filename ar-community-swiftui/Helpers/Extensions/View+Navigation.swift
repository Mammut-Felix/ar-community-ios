//
//  View+Navigation.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 23.02.22.
//

import SwiftUI

extension View {
    public func currentDeviceNavigationViewStyle(alwaysStacked: Bool) -> AnyView {
        if UIDevice.current.userInterfaceIdiom == .pad && !alwaysStacked {
            return AnyView(navigationViewStyle(DefaultNavigationViewStyle()))
        } else {
            return AnyView(navigationViewStyle(StackNavigationViewStyle()))
        }
    }
}
