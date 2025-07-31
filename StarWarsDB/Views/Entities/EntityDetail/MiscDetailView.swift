import SwiftUI

struct MiscInfoSection: View {
    @State var misc: Misc
    
    var body: some View {
        Section("Misc Infos") {
            EditableTextField(fieldName: "First Appearance", info: $misc.firstAppearance)
        }
    }
}

struct MiscDetailView: View {
    @Bindable var misc: Misc
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceMisc = [SourceEntity<Misc>]()
    
    var body: some View {
        NavigationStack {
            EntityDetailContentView(
                headerSection: SectionHeaderView(
                    name: $misc.name,
                    url: misc.url
                ),
                sidePanel: SidePanelView(
                    id: misc.id,
                    comments: Binding(
                        get: { misc.comments ?? "" },
                        set: { misc.comments = $0 }
                    ),
                    description: misc.description,
                    InfosSection: MiscInfoSection(misc: misc)
                ),
                sourceEntities: sourceMisc)
        }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update") {
                Task {
                    await misc.update()
                }
            }
        }
        }
    
    private func loadInitialSources() async {
        sourceMisc = await loadMiscSources(miscID: misc.id)
    }
}

#Preview {
    MiscDetailView(misc: .example)
}
