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
    @State private var gender: Gender = .Male
    //@State private var affiliations: [Organization] = []
    @State private var firstAppearance: String = ""
    @State private var comments: String = ""
    
    var onCharacterCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding()
                Form {
                    Section("Character Infos") {
                        //MultiFieldView(fieldName: "Aliases", infos: aliases)
                        GenderPicker(gender: $gender)
                        EditEntityInfoView(
                            fieldName: "Species",
                            entity: Binding(
                                get: {species ?? Species.empty },
                                set: {species = ($0 as! Species) }),
                            entityType: .species)
                        EditEntityInfoView(
                            fieldName: "Homeworld",
                            entity: Binding(
                                get: {homeworld ?? Planet.empty },
                                set: {homeworld = ($0 as! Planet) }),
                            entityType: .planet)
                        //MultiFieldView(fieldName: "Affiliation", entities: affiliations)
                        FieldView(fieldName: "First Appearance", info: $firstAppearance)
                    }
                    CommentsView(comments: $comments)
                    
                    Section {
                        Button("Save", action: saveCharacter)
                            .disabled(name.isEmpty)
                    }
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
