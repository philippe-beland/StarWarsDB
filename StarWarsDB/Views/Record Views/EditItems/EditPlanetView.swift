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
    
    @State private var sourcePlanets: [SourcePlanet] = SourcePlanet.example
    
    var body: some View {
        NavigationStack {
                RecordContentView(record: planet, sourceItems: sourcePlanets, InfosSection: InfosSection)
            }
        }
    private var InfosSection: some View {
        Section("Infos") {
            FieldView(fieldName: "Region", info: planet.region?.rawValue ?? "")
            FieldView(fieldName: "Sector", info: planet.sector ?? "")
            FieldView(fieldName: "System", info: planet.system ?? "")
            FieldView(fieldName: "Capital", info: planet.capitalCity ?? "")
            MultiFieldView(fieldName: "Destinations", infos: planet.destinations)
            FieldView(fieldName: "First Appearance", info: planet.firstAppearance ?? "")
        }
    }
}

#Preview {
    EditPlanetView(planet: .example)
}
