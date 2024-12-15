//
//  EditSpeciesView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct EditSpeciesView: View {
    @Bindable var species: Species
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceSpecies: [SourceSpecies] = SourceSpecies.example
    
    var body: some View {
        NavigationStack {
                RecordContentView(record: species, sourceItems: sourceSpecies, InfosSection: InfosSection)
            }
        }
    private var InfosSection: some View {
        Section("Infos") {
            FieldView(fieldName: "Homeworld", info: species.homeworld!.name)
            FieldView(fieldName: "First Appearance", info: species.firstAppearance ?? "")
        }
    }
}

#Preview {
    EditSpeciesView(species: .example)
}
