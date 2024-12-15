//
//  ChooseRecordView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct ChooseRecordView: View {
    @State private var searchText = ""

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
                        NavigationLink(destination: item.destinationView) {
                            RecordMenuView(imageName: item.imageName, type: item.type)
                        }
                    }
                }
            }
            .navigationTitle("Records")
            .searchable(text: $searchText)
        }
    }
    
    private var recordMenuItems: [RecordMenuItem] {
        [
            RecordMenuItem(imageName: "Luke_Skywalker", type: "Characters", destinationView: AnyView(EditCharacterView(character: .example))),
            RecordMenuItem(imageName: "Twi'lek", type: "Species", destinationView: AnyView(EditSpeciesView(species: .example))),
            RecordMenuItem(imageName: "Tatooine", type: "Planets", destinationView: AnyView(EditPlanetView(planet: .example))),
            RecordMenuItem(imageName: "Alphabet_Squadron", type: "Organizations", destinationView: AnyView(EditOrganizationView(organization: .example))),
            RecordMenuItem(imageName: "Millenium_Falcon", type: "Starships", destinationView: AnyView(EditStarshipView(starship: .example))),
            RecordMenuItem(imageName: "Dianoga", type: "Creatures", destinationView: AnyView(EditCreatureView(creature: .example))),
            RecordMenuItem(imageName: "R2_astromech_droid", type: "Droids", destinationView: AnyView(EditDroidView(droid: .example))),
            RecordMenuItem(imageName: "YT-1300", type: "Starship Models", destinationView: AnyView(EditStarshipModelView(starshipModel: .example))),
        ]
    }
}

struct RecordMenuItem: Identifiable {
    let id = UUID()
    let imageName: String
    let type: String
    let destinationView: AnyView
}

#Preview {
    ChooseRecordView()
}
