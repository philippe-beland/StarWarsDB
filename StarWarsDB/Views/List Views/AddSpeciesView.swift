//
//  AddSpeciesView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/24/24.
//

import SwiftUI

struct AddSpeciesView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var homeworld: Planet?
    @State private var firstAppearance: String?
    @State private var comments: String?
    
    var onSpeciesCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Infos") {
                    
                }
                
                Section {
                    Button("Save", action: saveSpecies)
                        .disabled(name.isEmpty)
                }
            }
        }
        .navigationTitle("Add new Species")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveSpecies() {
        let newSpecies = Species(name: name, homeworld: homeworld, firstAppearance: firstAppearance, comments: comments)
        newSpecies.save()
        onSpeciesCreation(newSpecies)
        dismiss()
    }
}
