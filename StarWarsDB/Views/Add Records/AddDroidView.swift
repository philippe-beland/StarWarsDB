//
//  AddDroidView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/24/24.
//

import SwiftUI

struct AddDroidView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var classType: String = ""
    @State private var firstAppearance: String = ""
    @State private var comments: String = ""
    
    var onDroidCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding()
                
                Form {
                    Section("Droid Infos") {
                        FieldView(fieldName: "Class Type", info: $classType)
                        FieldView(fieldName: "First Appearance", info: $firstAppearance)
                    }
                    CommentsView(comments: $comments)
                    
                    Section {
                        Button("Save", action: saveDroid)
                            .disabled(name.isEmpty)
                    }
                }
            }
        }
        .navigationTitle("Add new Droid")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveDroid() {
        let newDroid = Droid(name: name, classType: classType, firstAppearance: firstAppearance, comments: comments)
        newDroid.save()
        onDroidCreation(newDroid)
        dismiss()
    }
}
