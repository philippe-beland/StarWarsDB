//
//  ChooseRecordView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct ChooseRecordView: View {
    @StateObject var searchContext = SearchContext()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    NavigationLink {
                        FavoritesView()
                    } label: {
                        Text("Favorites")
                    }
                }
                
                Section {
                    ForEach(recordMenuItems) { item in
                        NavigationLink(destination: ListEntitiesView(entityType: item.type)) {
                            RecordMenuView(imageName: item.imageName, type: item.type.rawValue)
                        }
                    }
                }
            }
            .navigationTitle("Entities")
            .searchable(text: $searchContext.query)
        }
    }
    
    private var recordMenuItems: [RecordMenuItem] {
        [
            RecordMenuItem(imageName: "Luke_Skywalker", type: .character, destinationView: AnyView(EditCharacterView(character: .example))),
            RecordMenuItem(imageName: "Twi'lek", type: .species, destinationView: AnyView(EditSpeciesView(species: .example))),
            RecordMenuItem(imageName: "Tatooine", type: .planet, destinationView: AnyView(EditPlanetView(planet: .example))),
            RecordMenuItem(imageName: "Alphabet_Squadron", type: .organization, destinationView: AnyView(EditOrganizationView(organization: .example))),
            RecordMenuItem(imageName: "Millenium_Falcon", type: .starship, destinationView: AnyView(EditStarshipView(starship: .example))),
            RecordMenuItem(imageName: "Dianoga", type: .creature, destinationView: AnyView(EditCreatureView(creature: .example))),
            RecordMenuItem(imageName: "R2_astromech_droid", type: .droid, destinationView: AnyView(EditDroidView(droid: .example))),
            RecordMenuItem(imageName: "YT-1300", type: .starshipModel, destinationView: AnyView(EditStarshipModelView(starshipModel: .example))),
            RecordMenuItem(imageName: "YT-1300", type: .varia, destinationView: AnyView(EditVariaView(varia: .example)))
        ]
    }
}

struct RecordMenuItem: Identifiable {
    let id: UUID = UUID()
    let imageName: String
    let type: EntityType
    let destinationView: AnyView
}

#Preview {
    ChooseRecordView()
}
