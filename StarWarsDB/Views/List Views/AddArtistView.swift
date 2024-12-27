//
//  AddArtistView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/24/24.
//

import SwiftUI

struct AddArtistView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var comments: String = ""
    
    var onArtistCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding()
                Form {
                    CommentsView(comments: $comments)
                    
                    Section {
                        Button("Save", action: saveArtist)
                            .disabled(name.isEmpty)
                    }
                }
            }
        }
        .navigationTitle("Add new Artist")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveArtist() {
        let newArtist = Artist(name: name, comments: comments)
        newArtist.save()
        onArtistCreation(newArtist)
        dismiss()
    }
}
