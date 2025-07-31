import SwiftUI

struct DroidInfoSection: View {
    @State var droid: Droid
    
    var body: some View {
        Section("Droid Infos") {
            EditableTextField(fieldName: "First Appearance", info: $droid.firstAppearance)
        }
    }
}

struct DroidDetailView: View {
    @Bindable var droid: Droid
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State private var sourceDroids = [SourceEntity<Droid>]()
    
    var body: some View {
        NavigationStack {
            EntityDetailContentView(
                headerSection: SectionHeaderView(
                    name: $droid.name,
                    url: droid.url
                ),
                sidePanel: SidePanelView(
                    id: droid.id,
                    comments: Binding(
                        get: { droid.comments ?? "" },
                        set: { droid.comments = $0 }
                    ),
                    InfosSection: DroidInfoSection(droid: droid)
                ),
                sourceEntities: sourceDroids)
        }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update") {
                Task {
                    await droid.update()
                }
            }
        }
        }
    
    private func loadInitialSources() async {
        sourceDroids = await loadDroidSources(droidID: droid.id)
    }
}

#Preview {
    DroidDetailView(droid: .example)
}
