import SwiftUI

struct StarshipModelInfoSection: View {
    @State var starshipModel: StarshipModel
    
    var body: some View {
        Section("Starship Model Infos") {
            FieldView(fieldName: "Class Type", info: $starshipModel.classType)
            FieldView(fieldName: "Line", info: $starshipModel.line)
            FieldView(fieldName: "First Appearance", info: $starshipModel.firstAppearance)
        }
    }
}

struct StarshipModelDetailView: View {
    @Bindable var starshipModel: StarshipModel
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceStarshipModels = [SourceStarshipModel]()
    
    var body: some View {
        NavigationStack {
            EntityDetailContentView(entity: starshipModel, sourceEntities: sourceStarshipModels, InfosSection: StarshipModelInfoSection(starshipModel: starshipModel))
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
