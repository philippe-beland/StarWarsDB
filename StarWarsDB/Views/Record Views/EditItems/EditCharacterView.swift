//
//  EditCharacterView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import SwiftUI

struct EditCharacterView: View {
    @Bindable var character: Character
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State private var sourceCharacters = [SourceCharacter]()
    
    @State private var selectedOption: SourceType = .movies
    
    var body: some View {
        NavigationStack {
            RecordContentView(record: character, sourceItems: sourceCharacters, InfosSection: CharacterInfoSection(character: character))
        }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: character.update)
        }
    }
    
    private func loadInitialSources() async {
        sourceCharacters = await loadCharacterSources(characterID: character.id)
    }
}

#Preview {
    EditCharacterView(character: .example)
}
