//
//  EditCharacterView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import SwiftUI

struct EditCharacterView: View {
    @Bindable var character: Character
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedOption: SourceType = .movies
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(name: character.name, urlString: character.url)
                
                if horizontalSizeClass == .regular {
                    HStack {
                        SidePanelView(record: character, InfosSection: InfosSection)
                            .frame(width: 350)
                        Spacer()
                        SourcesSection()
                    }
                } else {
                    VStack {
                        SidePanelView(record: character, InfosSection: InfosSection)
                        Spacer()
                        SourcesSection()
                    }
                }
            }
        }
    }
    
    private var InfosSection: some View {
        Section("Infos") {
            multiFieldView(fieldName: "Aliases", infos: character.aliases)
            FieldView(fieldName: "Sex", info: character.sex.rawValue)
            FieldView(fieldName: "Species", info: character.species!.name)
            FieldView(fieldName: "Homeworld", info: character.homeworld!.name)
            multiFieldView(fieldName: "Affiliation", infos: character.affiliation)
            FieldView(fieldName: "First Appearance", info: character.firstAppearance ?? "")
        }
    }
}

#Preview {
    EditCharacterView(character: .example)
}
