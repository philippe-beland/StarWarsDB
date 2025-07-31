import SwiftUI

struct SpeciesInfoSection: View {
    @State var species: Species
    
    var body: some View {
        Section("Species Infos") {
            EditableLinkedEntityField(
                entity: Binding(
                    get: {species.homeworld ?? Planet.empty },
                    set: {species.homeworld = ($0 ) }),
                )
            EditableTextField(fieldName: "First Appearance", info: $species.firstAppearance)
        }
    }
}

struct SpeciesDetailView: View {
    @Bindable var species: Species
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceSpecies = [SourceEntity<Species>]()
    
    var body: some View {
        NavigationStack {
            EntityDetailContentView(
                headerSection: SectionHeaderView(
                    name: $species.name,
                    url: species.url
                ),
                sidePanel: SidePanelView(
                    id: species.id,
                    comments: Binding(
                        get: { species.comments ?? "" },
                        set: { species.comments = $0 }
                    ),
                    InfosSection: SpeciesInfoSection(species: species)
                ),
                sourceEntities: sourceSpecies)
        }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update") {
                Task {
                    await species.update()
                }
            }
        }
        }
    
    private func loadInitialSources() async {
        sourceSpecies = await loadSpeciesSources(speciesID: species.id)
    }
}

#Preview {
    SpeciesDetailView(species: .example)
}
