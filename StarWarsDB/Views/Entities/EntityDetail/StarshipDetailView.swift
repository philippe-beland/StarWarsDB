import SwiftUI

struct StarshipInfoSection: View {
    @State var starship: Starship
    
    var body: some View {
        Section("Starship Infos") {
            EntityInfoEditView(
                fieldName: "Model",
                entity: Binding(
                    get: {starship.model ?? StarshipModel.empty },
                    set: {starship.model = ($0 ) }),
                )
            FieldView(fieldName: "First Appearance", info: $starship.firstAppearance)
        }
    }
}

struct StarshipDetailView: View {
    @Bindable var starship: Starship
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceStarships = [SourceEntity<Starship>]()
    
    var body: some View {
        NavigationStack {
            EntityDetailContentView(
                headerSection: SectionHeaderView(
                    name: $starship.name,
                    url: starship.url
                ),
                sidePanel: SidePanelView(
                    id: starship.id,
                    comments: Binding(
                        get: { starship.comments ?? "" },
                        set: { starship.comments = $0 }
                    ),
                    InfosSection: StarshipInfoSection(starship: starship)
                ),
                sourceEntities: sourceStarships)
        }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: starship.update)
        }
        }
    
    private func loadInitialSources() async {
        sourceStarships = await loadStarshipSources(starshipID: starship.id)
    }
}

#Preview {
    StarshipDetailView(starship: .example)
}
