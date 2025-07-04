import SwiftUI

struct StarshipInfoSection: View {
    @State var starship: Starship
    
    var body: some View {
        Section("Starship Infos") {
            EditEntityInfoView(
                fieldName: "Model",
                entity: Binding(
                    get: {starship.model ?? StarshipModel.empty },
                    set: {starship.model = ($0 as! StarshipModel) }),
                entityType: .starshipModel)
            FieldView(fieldName: "First Appearance", info: $starship.firstAppearance)
        }
    }
}

struct StarshipDetailView: View {
    @Bindable var starship: Starship
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceStarships = [SourceStarship]()
    
    var body: some View {
        NavigationStack {
            EntityDetailContentView(entity: starship, sourceEntities: sourceStarships, InfosSection: StarshipInfoSection(starship: starship))
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
