import SwiftUI

struct StarshipModelInfoSection: View {
    @State var starshipModel: StarshipModel
    
    var body: some View {
        Section("Starship Model Infos") {
            EditableTextField(fieldName: "Class Type", info: $starshipModel.classType)
            EditableTextField(fieldName: "Line", info: $starshipModel.line)
            EditableTextField(fieldName: "First Appearance", info: $starshipModel.firstAppearance)
        }
    }
}

struct StarshipModelDetailView: View {
    @Bindable var starshipModel: StarshipModel
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceStarshipModels = [SourceEntity<StarshipModel>]()
    
    var body: some View {
        NavigationStack {
            EntityDetailContentView(
                headerSection: SectionHeaderView(
                    name: $starshipModel.name,
                    url: starshipModel.url
                ),
                sidePanel: SidePanelView(
                    id: starshipModel.id,
                    comments: Binding(
                        get: { starshipModel.comments ?? "" },
                        set: { starshipModel.comments = $0 }
                    ),
                    InfosSection: StarshipModelInfoSection(starshipModel: starshipModel)
                ),
                sourceEntities: sourceStarshipModels)
        }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: starshipModel.update)
        }
        }
    
    private func loadInitialSources() async {
        sourceStarshipModels = await loadStarshipModelSources(starshipModelID: starshipModel.id)
    }
}

#Preview {
    StarshipModelDetailView(starshipModel: .example)
}
