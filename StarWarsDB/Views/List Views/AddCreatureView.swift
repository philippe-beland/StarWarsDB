//
//  AddCreatureView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/24/24.
//

import SwiftUI

struct AddCreatureView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var designation: String?
    @State private var homeworld: Planet?
    @State private var firstAppearance: String?
    @State private var comments: String?
    
    var onCreatureCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Infos") {
                    
                }
                
                Section {
                    Button("Save", action: saveCreature)
                        .disabled(name.isEmpty)
                }
            }
        }
        .navigationTitle("Add new Creature")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveCreature() {
        let newCreature = Creature(name: name, designation: designation, homeworld: homeworld, firstAppearance: firstAppearance, comments: comments)
        newCreature.save()
        onCreatureCreation(newCreature)
        dismiss()
    }
}
