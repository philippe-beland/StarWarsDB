//
//  EditStarshipView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct EditStarshipView: View {
    @Bindable var starship: Starship
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceStarships = [SourceStarship]()
    
    var body: some View {
        NavigationStack {
            RecordContentView(record: starship, sourceItems: sourceStarships, InfosSection: StarshipInfoSection(starship: starship))
            }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: starship.update)
        }
        }
    
    private func loadInitialSources() async {
        sourceStarships = await loadSourceStarships(recordField: "starship", recordID: starship.id)
    }
}

#Preview {
    EditStarshipView(starship: .example)
}
