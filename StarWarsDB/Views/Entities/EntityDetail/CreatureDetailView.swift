import SwiftUI

struct CreatureInfoSection: View {
    @State var creature: Creature
    
    var body: some View {
        Section("Creature Infos") {
            EditableLinkedEntityField(
                entity: Binding(
                    get: {creature.homeworld ?? Planet.empty },
                    set: {creature.homeworld = ($0 ) }),
                )
            EditableTextField(fieldName: "First Appearance", info: $creature.firstAppearance)
        }
    }
}

struct CreatureDetailView: View {
    @Bindable var creature: Creature
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State private var sourceCreatures = [SourceEntity<Creature>]()
    
    var body: some View {
        NavigationStack {
            EntityDetailContentView(
                headerSection: SectionHeaderView(
                    name: $creature.name,
                    url: creature.url
                ),
                sidePanel: SidePanelView(
                    id: creature.id,
                    comments: Binding(
                        get: { creature.comments ?? "" },
                        set: { creature.comments = $0 }
                    ),
                    InfosSection: CreatureInfoSection(creature: creature)
                ),
                sourceEntities: sourceCreatures)
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
    CreatureDetailView(creature: .example)
}
