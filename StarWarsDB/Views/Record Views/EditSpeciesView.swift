//
//  EditSpeciesView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct EditSpeciesView: View {
    @Bindable var species: Species
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceSpecies: [SourceSpecies] = [.example, .example, .example]
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(name: species.name, urlString: species.url)
                
                if horizontalSizeClass == .regular {
                    HStack {
                        SidePanelView(record: species, InfosSection: InfosSection)
                            .frame(width: 350)
                        Spacer()
                        SourcesSection(sourceItems: sourceSpecies)
                    }
                } else {
                    VStack {
                        SidePanelView(record: species, InfosSection: InfosSection)
                        Spacer()
                        SourcesSection(sourceItems: sourceSpecies)
                    }
                }
            }
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
