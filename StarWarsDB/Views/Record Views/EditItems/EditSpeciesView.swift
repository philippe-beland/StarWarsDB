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
        .toolbar {
            Button ("Update", action: species.update)
        }
        }
    
    private func loadInitialSources() async {
        sourceSpecies = await loadSpeciesSources(speciesID: species.id)
    }
}

#Preview {
    EditSpeciesView(species: .example)
}
