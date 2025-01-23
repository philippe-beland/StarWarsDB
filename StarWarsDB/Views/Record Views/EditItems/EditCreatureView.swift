//
//  EditCreatureView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct EditCreatureView: View {
    @Bindable var creature: Creature
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceCreatures = [SourceCreature]()
    
    var body: some View {
        NavigationStack {
            RecordContentView(record: creature, sourceItems: sourceCreatures, InfosSection: CreatureInfoSection(creature: creature))
            }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: creature.update)
        }
        }

    
    private func loadInitialSources() async {
        sourceCreatures = await loadSourceCreatures(recordField: "creature", recordID: creature.id)
    }
}

#Preview {
    EditCreatureView(creature: .example)
}
