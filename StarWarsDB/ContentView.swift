import SwiftUI

struct ContentView: View {
    @State var isAuthenticated = false
    
    var body: some View {
        TabView {
            ChooseSourceView()
                .tabItem {
                    Label("Sources", systemImage: "star")
                }
            ChooseRecordView()
                .tabItem {
                    Label("Records", systemImage: "star")
                }
            Group {
                if isAuthenticated {
                    ProfileView()
                } else {
                    AuthView()
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
