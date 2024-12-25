//
//  AddStarshipModelView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/24/24.
//

import SwiftUI

struct AddStarshipModelView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var classType: String?
    @State private var line: String?
    @State private var firstAppearance: String?
    @State private var comments: String?
    
    var onStarshipModelCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Infos") {
                    
                }
                
                Section {
                    Button("Save", action: saveStarshipModel)
                        .disabled(name.isEmpty)
                }
            }
        }
        .navigationTitle("Add new Starship Model")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveStarshipModel() {
        let newStarshipModel = StarshipModel(name: name, classType: classType, line: line, firstAppearance: firstAppearance, comments: comments)
        newStarshipModel.save()
        onStarshipModelCreation(newStarshipModel)
        dismiss()
    }
}
