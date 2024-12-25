//
//  AddCharacterView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/24/24.
//

import SwiftUI

struct AddCharacterView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var aliases: [String] = []
    @State private var species: Species?
    @State private var homeworld: Planet?
    @State private var gender: Gender?
    //@State private var affiliations: [Organization] = []
    @State private var firstAppearance: String?
    @State private var comments: String?
    
    var onCharacterCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Character Infos") {
//                    MultiFieldView(fieldName: "Aliases", infos: aliases)
//                    FieldView(fieldName: "Gender", info: gender)
//                    FieldView(fieldName: "Species", info: species)
//                    FieldView(fieldName: "Homeworld", info: homeworld)
//                    //MultiFieldView(fieldName: "Affiliation", entities: affiliations)
//                    FieldView(fieldName: "First Appearance", info: firstAppearance)
                }
                
                Section {
                    Button("Save", action: saveCharacter)
                        .disabled(name.isEmpty)
                }
            }
        }
        .navigationTitle("Add new Character")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveCharacter() {
        let newCharacter = Character(name: name, aliases: aliases, species: species, homeworld: homeworld, gender: gender, firstAppearance: firstAppearance, comments: comments)
        newCharacter.save()
        onCharacterCreation(newCharacter)
        dismiss()
    }
}
