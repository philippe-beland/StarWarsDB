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
    
    @State private var sourceCreatures: [SourceCreature] = SourceCreature.example
    
    var body: some View {
        NavigationStack {
                RecordContentView(record: creature, sourceItems: sourceCreatures, InfosSection: InfosSection)
            }
        }
    private var InfosSection: some View {
        Section("Infos") {
            FieldView(fieldName: "Homeworld", info: creature.homeworld!.name)
            FieldView(fieldName: "First Appearance", info: creature.firstAppearance ?? "")
        }
    }
}

#Preview {
    EditCreatureView(creature: .example)
}
