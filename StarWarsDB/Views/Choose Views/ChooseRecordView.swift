import SwiftUI

struct MenuEntity: Identifiable {
    let id: UUID = UUID()
    let imageName: String
    let type: EntityType
    let destinationView: AnyView
}

struct ChooseEntityTypeView: View {
    @StateObject var searchContext = SearchContext()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    ForEach(MenuEntities) { menuEntity in
                        NavigationLink(destination: ListEntitiesView(entityType: menuEntity.type)) {
                            EntityMenuView(imageName: menuEntity.imageName, type: menuEntity.type.rawValue)
                        }
                    }
                }
            }
            .navigationTitle("Entities")
            .searchable(text: $searchContext.query)
        }
    }
    
    private var MenuEntities: [MenuEntity] {
        [
            MenuEntity(imageName: "Luke_Skywalker", type: .character, destinationView: AnyView(EditCharacterView(character: .example))),
            MenuEntity(imageName: "Twi'lek", type: .species, destinationView: AnyView(EditSpeciesView(species: .example))),
            MenuEntity(imageName: "Tatooine", type: .planet, destinationView: AnyView(EditPlanetView(planet: .example))),
            MenuEntity(imageName: "Alphabet_Squadron", type: .organization, destinationView: AnyView(EditOrganizationView(organization: .example))),
            MenuEntity(imageName: "Millenium_Falcon", type: .starship, destinationView: AnyView(EditStarshipView(starship: .example))),
            MenuEntity(imageName: "Dianoga", type: .creature, destinationView: AnyView(EditCreatureView(creature: .example))),
            MenuEntity(imageName: "R2_astromech_droid", type: .droid, destinationView: AnyView(EditDroidView(droid: .example))),
            MenuEntity(imageName: "YT-1300", type: .starshipModel, destinationView: AnyView(EditStarshipModelView(starshipModel: .example))),
            MenuEntity(imageName: "YT-1300", type: .varia, destinationView: AnyView(EditVariaView(varia: .example)))
        ]
    }
}

#Preview {
    ChooseEntityTypeView()
}
