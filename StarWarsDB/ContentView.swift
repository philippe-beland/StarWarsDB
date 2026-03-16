import SwiftUI

struct ContentView: View {
    @State private var selectedTab: AppTab = .sources
    @State private var isAuthenticated = false

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Sources", systemImage: "play.square.stack", value: .sources) {
                SourceBrowserView()
            }

            Tab("Entities", systemImage: "list.bullet.clipboard", value: .entities) {
                EntityTypeSelectorView()
            }

            Tab("Settings", systemImage: "gearshape", value: .settings) {
                if isAuthenticated {
                    UserProfileView()
                } else {
                    AuthenticationView()
                }
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .task {
            for await state in supabase.auth.authStateChanges {
                if [.initialSession, .signedIn, .signedOut].contains(state.event) {
                    isAuthenticated = state.session != nil
                }
            }
        }
    }
}

private enum AppTab: Hashable {
    case sources
    case entities
    case settings
}

#Preview {
    ContentView()
}
