//
//  ChooseRecordView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct ChooseRecordView: View {

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                List {
                    NavigationLink {
                        EditCharacterView(character: .example)
                    } label: {
                        RecordMenuView(imageName: "Luke_Skywalker", type: "Characters")
                    }
                    
                    NavigationLink {
                        EditCreatureView(creature: .example)
                    } label: {
                        RecordMenuView(imageName: "Dianoga", type: "Creatures")
                    }
                    
                    
                    NavigationLink {
                        EditDroidView(droid: .example)
                    } label: {
                        RecordMenuView(imageName: "R2_astromech_droid", type: "Droids")
                    }
                    
                    NavigationLink {
                        EditOrganizationView(organization: .example)
                    } label: {
                        RecordMenuView(imageName: "Alphabet_Squadron", type: "Organizations")
                    }
                    
                    NavigationLink {
                        EditPlanetView(planet: .example)
                    } label: {
                        RecordMenuView(imageName: "Tatooine", type: "Planets")
                    }
                    
                    NavigationLink {
                        EditSpeciesView(species: .example)
                    } label: {
                        RecordMenuView(imageName: "Twi'lek", type: "Species")
                    }
                    
                    NavigationLink {
                        EditStarshipView(starship: .example)
                    } label: {
                        RecordMenuView(imageName: "Millenium_Falcon", type: "Starships")
                    }
                    
                    NavigationLink {
                        EditStarshipModelView(starshipModel: .example)
                    } label: {
                        RecordMenuView(imageName: "YT-1300", type: "Starship Models")
                    }
                }
                .navigationTitle("Records")
            }
        }
    }
}

#Preview {
    ChooseRecordView()
}
