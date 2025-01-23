//
//  EditPlanetView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct EditPlanetView: View {
    @Bindable var planet: Planet
    @Environment(\.dismiss) var dismiss
    
    @State private var sourcePlanets = [SourcePlanet]()
    
    var body: some View {
        NavigationStack {
            RecordContentView(record: planet, sourceItems: sourcePlanets, InfosSection: PlanetInfoSection(planet: planet))
            }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: planet.update)
        }
        }

    
    private func loadInitialSources() async {
        sourcePlanets = await loadSourcePlanets(recordField: "planet", recordID: planet.id)
    }
}

#Preview {
    EditPlanetView(planet: .example)
}
