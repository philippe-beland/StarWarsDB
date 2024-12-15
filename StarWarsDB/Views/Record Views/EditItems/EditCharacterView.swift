//
//  EditCharacterView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import SwiftUI

struct EditCharacterView: View {
    @Bindable var character: Character
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceCharacters: [SourceCharacter] = SourceCharacter.example
    
    @State private var selectedOption: SourceType = .movies
    
    var body: some View {
        NavigationStack {
                RecordContentView(record: character, sourceItems: sourceCharacters, InfosSection: InfosSection)
            }
        }
    
    private var InfosSection: some View {
        Section("Infos") {
            MultiFieldView(fieldName: "Aliases", infos: character.aliases)
            FieldView(fieldName: "Sex", info: character.sex.rawValue)
            FieldView(fieldName: "Species", info: character.species!.name)
            FieldView(fieldName: "Homeworld", info: character.homeworld!.name)
            MultiFieldView(fieldName: "Affiliation", infos: character.affiliation)
            FieldView(fieldName: "First Appearance", info: character.firstAppearance ?? "")
        }
    }
}

#Preview {
    EditCharacterView(character: .example)
}
