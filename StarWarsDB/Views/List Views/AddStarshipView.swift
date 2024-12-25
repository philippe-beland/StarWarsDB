//
//  AddStarshipView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/24/24.
//

import SwiftUI

struct AddStarshipView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var model: StarshipModel?
    @State private var firstAppearance: String?
    @State private var comments: String?
    
    var onStarshipCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Infos") {
                    
                }
                
                Section {
                    Button("Save", action: saveStarship)
                        .disabled(name.isEmpty)
                }
            }
        }
        .navigationTitle("Add new Starship")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveStarship() {
        let newStarship = Starship(name: name, model: model, firstAppearance: firstAppearance, comments: comments)
        newStarship.save()
        onStarshipCreation(newStarship)
        dismiss()
    }
}
