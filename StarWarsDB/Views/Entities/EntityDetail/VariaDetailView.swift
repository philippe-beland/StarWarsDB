import SwiftUI

struct VariaInfoSection: View {
    @State var varia: Varia
    
    var body: some View {
        Section("Varia Infos") {
            EditableTextField(fieldName: "First Appearance", info: $varia.firstAppearance)
        }
    }
}

struct VariaDetailView: View {
    @Bindable var varia: Varia
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceVarias = [SourceEntity<Varia>]()
    
    var body: some View {
        NavigationStack {
            EntityDetailContentView(
                headerSection: SectionHeaderView(
                    name: $varia.name,
                    url: varia.url
                ),
                sidePanel: SidePanelView(
                    id: varia.id,
                    comments: Binding(
                        get: { varia.comments ?? "" },
                        set: { varia.comments = $0 }
                    ),
                    InfosSection: VariaInfoSection(varia: varia)
                ),
                sourceEntities: sourceVarias)
        }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: varia.update)
        }
        }
    
    private func loadInitialSources() async {
        sourceVarias = await loadVariaSources(variaID: varia.id)
    }
}

#Preview {
    VariaDetailView(varia: .example)
}
