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
    
    @State private var sourceStarships: [SourceStarship] = SourceStarship.example
    
    var body: some View {
        NavigationStack {
                RecordContentView(record: starship, sourceItems: sourceStarships, InfosSection: InfosSection)
            }
        }
    private var InfosSection: some View {
        Section("Infos") {
            FieldView(fieldName: "Model", info: starship.model?.name ?? "")
            FieldView(fieldName: "First Appearance", info: starship.firstAppearance ?? "")
        }
    }
}

#Preview {
    EditStarshipView(starship: .example)
}
