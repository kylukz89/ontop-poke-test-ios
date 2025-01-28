//
//  BaseView.swift
//  PokeOntopTest
//
//  Created by Igor Maximo on 28/01/25.
//

import SwiftUI

struct BaseView<Content: View>: View {
    
    @StateObject private var networkMonitor = NetworkMonitor()
    let content: () -> Content

    var body: some View {
        ZStack {
            content()
            if !networkMonitor.isConnected {
                NoInternetView()
            }
        }
    }
}
