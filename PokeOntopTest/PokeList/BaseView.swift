 
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
