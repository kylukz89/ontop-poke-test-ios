import SwiftUI

enum ErrorScreenType {
    case noContent
    case loading
    case apiError(retryAction: () -> Void)
}

struct ErrorScreen: View {
    
    let type: ErrorScreenType
    
    var body: some View {
        VStack(spacing: 16) {
            switch type {
            case .noContent:
                Text("No Content Available")
                    .font(.headline)
                    .foregroundColor(.gray)
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            case .apiError(let retryAction):
                VStack {
                    Text("An error occurred. Please try again.")
                        .font(.headline)
                        .foregroundColor(.red)
                    Button(action: retryAction) {
                        Text("Try Again")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
    }
}
 
struct BaseView<Content: View>: View {
    
    @StateObject private var networkMonitor = NetworkMonitor()
    @Binding var errorType: ErrorScreenType?
    let content: () -> Content

    init(errorType: Binding<ErrorScreenType?>, @ViewBuilder content: @escaping () -> Content) {
        self._errorType = errorType
        self.content = content
    }

    var body: some View {
        ZStack {
            content().opacity(errorType == nil ? 1 : 0)
            if let errorType = errorType { ErrorScreen(type: errorType) }
            if !networkMonitor.isConnected { NoInternetView() }
        }
    }
}

