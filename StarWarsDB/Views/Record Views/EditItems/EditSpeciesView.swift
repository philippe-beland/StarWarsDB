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
    
    @State private var sourceSpecies = [SourceSpecies]()
    
    var body: some View {
        NavigationStack {
            RecordContentView(record: species, sourceItems: sourceSpecies, InfosSection: SpeciesInfoSection(species: species))
            }
        .task { await loadInitialSources() }
        }
    
    private func loadInitialSources() async {
        sourceSpecies = await loadSourceSpecies(recordField: "species", recordID: species.id.uuidString)
    }
}

#Preview {
    EditSpeciesView(species: .example)
}
