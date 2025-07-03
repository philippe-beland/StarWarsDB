import SwiftUI

struct DroidInfoSection: View {
    @State var droid: Droid
    
    var body: some View {
        Section("Droid Infos") {
            FieldView(fieldName: "First Appearance", info: $droid.firstAppearance)
        }
    }
}

struct EditDroidView: View {
    @Bindable var droid: Droid
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State private var sourceDroids = [SourceDroid]()
    
    var body: some View {
        NavigationStack {
            EntityContentView(entity: droid, sourceEntities: sourceDroids, InfosSection: DroidInfoSection(droid: droid))
            }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: droid.update)
        }
        }
    
    private func loadInitialSources() async {
        sourceDroids = await loadDroidSources(droidID: droid.id)
    }
}

#Preview {
    EditDroidView(droid: .example)
}
