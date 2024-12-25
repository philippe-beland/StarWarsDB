//
//  AddVariaView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/24/24.
//

import SwiftUI

struct AddVariaView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var firstAppearance: String?
    @State private var comments: String?
    
    var onVariaCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Infos") {
                    
                }
                
                Section {
                    Button("Save", action: saveVaria)
                        .disabled(name.isEmpty)
                }
            }
        }
        .navigationTitle("Add new Varia")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveVaria() {
        let newVaria = Varia(name: name, firstAppearance: firstAppearance, comments: comments)
        newVaria.save()
        onVariaCreation(newVaria)
        dismiss()
    }
}
