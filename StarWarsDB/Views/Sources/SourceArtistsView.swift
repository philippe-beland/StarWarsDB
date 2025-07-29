import SwiftUI

struct ArtistsVStack: View {
    var source: Source?
    
    @State var artists: [SourceEntity<Artist>] = []
    @State var showEditArtistSheet = false
    
    var body: some View {
        VStack {
            Button("Artists") { showEditArtistSheet.toggle() }
            ForEach(artists) { artist in
                Text(artist.entity.name)
            }
        }
        .sheet(isPresented: $showEditArtistSheet) {
            ExpandedSourceArtistsView(sourceArtists: $artists, source: source)
        }
    }
}

struct ExpandedSourceArtistsView: View {
    @Binding var sourceArtists: [SourceEntity<Artist>]
    var source: Source?
    @State var showAddArtistSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sourceArtists) { sourceEntity in
                    Text(sourceEntity.entity.name)
                }
                .onDelete(perform: deleteEntity)
            }
            .navigationTitle("Artists")
            .toolbar {
                Button("Add Artist") {
                    showAddArtistSheet.toggle()
                }
                .sheet(isPresented: $showAddArtistSheet) {
                    EntitySelectorView<Artist>(sourceEntities: []) { artists, _ in
                        if let source {
                            for artist in artists {
                                let newArtist = SourceEntity<Artist>(source: source, entity: artist , appearance: .present)
                                if !sourceArtists.contains(newArtist) {
                                    newArtist.save()
                                    sourceArtists.append(newArtist)
                                } else {
                                    print("Already exists for that source")
                                }
                            }
                        }
                    }
                }
            }
        }
    }

        private func deleteEntity(_ indexSet: IndexSet) {
        for index: IndexSet.Element in indexSet {
            let entity = sourceArtists[index]
            sourceArtists.remove(at: index)
            entity.delete()
        }
    }
}

//#Preview {
//    @Previewable var sourceArtists = SourceEntity<Artist>(source: .example, entity: .example, appearance: .present)
//    @Previewable @State var examples = sourceArtists.examples
//    ExpandedSourceArtistsView(sourceArtists: $examples)
//}
