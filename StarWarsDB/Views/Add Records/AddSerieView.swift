//
//  AddSerieView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/26/24.
//

import SwiftUI

struct AddSerieView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var name: String
    @State private var sourceType: SourceType = .comics
    @State private var comments: String = ""
    
    var onSerieCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding()
                Form {
                    SourceTypePicker(sourceType: $sourceType)
                    CommentsView(comments: $comments)
                    
                    Section {
                        Button("Save", action: saveSerie)
                            .disabled(name.isEmpty)
                    }
                }
            }
        }
        .navigationTitle("Add new Serie")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveSerie() {
        let newSerie = Serie(name: name, sourceType: sourceType, comments: comments)
        newSerie.save()
        onSerieCreation(newSerie)
        dismiss()
    }
}
