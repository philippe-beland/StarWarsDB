import SwiftUI

struct CreatureInfoSection: View {
    @State var creature: Creature
    
    var body: some View {
        Section("Creature Infos") {
            EditEntityInfoView(
                fieldName: "Homeworld",
                entity: Binding(
                    get: {creature.homeworld ?? Planet.empty },
                    set: {creature.homeworld = ($0 as! Planet) }),
                entityType: .planet)
            FieldView(fieldName: "First Appearance", info: $creature.firstAppearance)
        }
    }
}

struct EditCreatureView: View {
    @Bindable var creature: Creature
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State private var sourceCreatures = [SourceCreature]()
    
    var body: some View {
        NavigationStack {
            EntityContentView(entity: creature, sourceEntities: sourceCreatures, InfosSection: CreatureInfoSection(creature: creature))
            }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: creature.update)
        }
        }

    
    private func loadInitialSources() async {
        sourceCreatures = await loadCreatureSources(creatureID: creature.id)
    }
}

#Preview {
    EditCreatureView(creature: .example)
}
