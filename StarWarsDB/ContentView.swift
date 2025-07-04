import SwiftUI

struct ContentView: View {
    @State var isAuthenticated = false
    
    var body: some View {
        TabView {
            SourceBrowserView()
                .tabItem {
                    Label("Sources", systemImage: "play.square.stack")
                }
            EntityBrowserView()
                .tabItem {
                    Label("Entities", systemImage: "list.bullet.clipboard.fill")
                }
            Group {
                if isAuthenticated {
                    UserProfileView()
                } else {
                    AuthenticationView()
                }
            }
            .tabItem{
                Label("Settings", systemImage: "gearshape")
            }
            .task {
                for await state in supabase.auth.authStateChanges {
                    if [.initialSession, .signedIn, .signedOut].contains(state.event) {
                        isAuthenticated = state.session != nil
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
