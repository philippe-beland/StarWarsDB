//
//  EditArtistView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct EditArtistView: View {
    @Bindable var artist: Artist
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceArtists: [SourceArtist] = SourceArtist.example
    
    var body: some View {
        NavigationStack {
            RecordContentView(record: artist, sourceItems: sourceArtists, InfosSection: ArtistInfoSection(artist: artist))
        }
    }
}

#Preview {
    EditArtistView(artist: .example)
}
