import SwiftUI

struct ArtistsVStack: View {
    var source: Source?
    
    @State var artists: [SourceArtist] = []
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
    @Binding var sourceArtists: [SourceArtist]
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
                    ChooseEntityView(entityType: .artist, isSourceEntity: false, sourceEntities: []) { artists, _ in
                        if let source {
                            for artist in artists {
                                let newArtist = SourceArtist(source: source, entity: artist as! Artist)
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
