import SwiftUI

struct SpeciesInfoSection: View {
    @State var species: Species
    
    var body: some View {
        Section("Species Infos") {
            EditEntityInfoView(
                fieldName: "Homeworld",
                entity: Binding(
                    get: {species.homeworld ?? Planet.empty },
                    set: {species.homeworld = ($0 as! Planet) }),
                entityType: .planet)
            FieldView(fieldName: "First Appearance", info: $species.firstAppearance)
        }
    }
}

struct EditSpeciesView: View {
    @Bindable var species: Species
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceSpecies = [SourceSpecies]()
    
    var body: some View {
        NavigationStack {
            EntityContentView(entity: species, sourceEntities: sourceSpecies, InfosSection: SpeciesInfoSection(species: species))
            }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: species.update)
        }
        }
    
    private func loadInitialSources() async {
        sourceSpecies = await loadSpeciesSources(speciesID: species.id)
    }
}

#Preview {
    EditSpeciesView(species: .example)
}
