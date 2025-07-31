import SwiftUI

struct AuthorsVStack: View {
    var source: Source?
    @Binding var sourceAuthors: [SourceCreator<Author>]
    
    @State var showEditAuthorSheet = false
    
    private var sortedAuthors: [SourceCreator<Author>] {
        sourceAuthors.sorted(by: { $0.creator.name < $1.creator.name })
    }
    
    var body: some View {
        VStack {
            Button("Authors") { showEditAuthorSheet.toggle() }
            ForEach(sortedAuthors) { sourceAuthor in
                Text(sourceAuthor.creator.name)
            }
        }
        .sheet(isPresented: $showEditAuthorSheet) {
            ExpandedSourceAuthorsView(sourceAuthors: $sourceAuthors, source: source)
        }
    }
}

struct ExpandedSourceAuthorsView: View {
    @Binding var sourceAuthors: [SourceCreator<Author>]
    var source: Source?
    @State var showAddAuthorSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sourceAuthors) { sourceAuthor in
                    Text(sourceAuthor.creator.name)
                }
                .onDelete(perform: deleteEntity)
            }
            .navigationTitle("Authors")
            .toolbar {
                Button("Add Author") {
                    showAddAuthorSheet.toggle()
                }
                .sheet(isPresented: $showAddAuthorSheet) {
                    CreatorSelectorView<Author>(sourceCreators: []) { authors in
                        if let source {
                            for author in authors {
                                let newAuthor = SourceCreator<Author>(source: source, creator: author)
                                if !sourceAuthors.contains(newAuthor) {
                                    newAuthor.save()
                                    sourceAuthors.append(newAuthor)
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
            let entity = sourceAuthors[index]
            sourceAuthors.remove(at: index)
            entity.delete()
        }
    }
}

#Preview {
    @Previewable @State var sourceAuthors = [SourceCreator<Author>(source: .example, creator: .example)]
    ExpandedSourceAuthorsView(sourceAuthors: $sourceAuthors)
}
