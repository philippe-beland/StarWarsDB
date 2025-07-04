import SwiftUI

struct ArtistInfoSection: View {
    @State var artist: Artist
    
    var body: some View {
        Section("Artist Infos") {
        }
    }
}

struct ArtistDetailView: View {
    @Bindable var artist: Artist
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State private var sourceArtists = [SourceArtist]()
    
    var body: some View {
        NavigationStack {
            EntityDetailContentView(entity: artist, sourceEntities: sourceArtists, InfosSection: ArtistInfoSection(artist: artist))
        }
        .toolbar {
            Button ("Update", action: artist.update)
        }
    }
}

#Preview {
    ArtistDetailView(artist: .example)
}
