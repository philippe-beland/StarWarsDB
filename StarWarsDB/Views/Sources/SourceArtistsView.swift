import SwiftUI

struct ArtistsVStack: View {
    var source: Source?
    
    @Binding var sourceArtists: [SourceCreator<Artist>]
    @State var showEditArtistSheet = false
    
    private var sortedArtists: [SourceCreator<Artist>] {
        sourceArtists.sorted(by: { $0.creator.name < $1.creator.name })
    }
    
    var body: some View {
        VStack {
            Button("Artists") { showEditArtistSheet.toggle() }
            ForEach(sortedArtists) { sourceArtist in
                Text(sourceArtist.creator.name)
            }
        }
        .sheet(isPresented: $showEditArtistSheet) {
            ExpandedSourceArtistsView(sourceArtists: $sourceArtists, source: source)
        }
    }
}

struct ExpandedSourceArtistsView: View {
    @Binding var sourceArtists: [SourceCreator<Artist>]
    var source: Source?
    @State var showAddArtistSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sourceArtists) { sourceArtist in
                    Text(sourceArtist.creator.name)
                }
                .onDelete(perform: deleteEntity)
            }
            .navigationTitle("Artists")
            .toolbar {
                Button("Add Artist") {
                    showAddArtistSheet.toggle()
                }
                .sheet(isPresented: $showAddArtistSheet) {
                    CreatorSelectorView<Artist>(sourceCreators: []) { artists in
                        if let source {
                            for artist in artists {
                                let newArtist = SourceCreator<Artist>(source: source, creator: artist)
                                if !sourceArtists.contains(newArtist) {
                                    newArtist.save()
                                    sourceArtists.append(newArtist)
                                } else {
                                    appLogger.info("Already exists for that source")
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
