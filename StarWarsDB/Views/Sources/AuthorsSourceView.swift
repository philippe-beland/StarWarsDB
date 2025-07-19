import SwiftUI

struct AuthorsVStack: View {
    var source: Source?
    
    @State var authors: [SourceEntity<Author>] = []
    @State var showEditAuthorSheet = false
    
    var body: some View {
        VStack {
            Button("Authors") { showEditAuthorSheet.toggle() }
            ForEach(authors) { author in
                Text(author.entity.name)
            }
        }
        .sheet(isPresented: $showEditAuthorSheet) {
            ExpandedSourceAuthorsView(sourceAuthors: $authors, source: source)
        }
    }
}

struct ExpandedSourceAuthorsView: View {
    @Binding var sourceAuthors: [SourceEntity<Author>]
    var source: Source?
    @State var showAddAuthorSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sourceAuthors) { sourceEntity in
                    Text(sourceEntity.entity.name)
                }
                .onDelete(perform: deleteEntity)
            }
            .navigationTitle("Authors")
            .toolbar {
                Button("Add Author") {
                    showAddAuthorSheet.toggle()
                }
                .sheet(isPresented: $showAddAuthorSheet) {
                    ChooseEntityView<Author>(isSourceEntity: false, sourceEntities: []) { authors, _ in
                        if let source {
                            for author in authors {
                                let newAuthor = SourceEntity<Author>(source: source, entity: author, appearance: .present)
                                if !sourceAuthors.contains(newAuthor) {
                                    newAuthor.save()
                                    sourceAuthors.append(newAuthor)
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
            let entity = sourceAuthors[index]
            sourceAuthors.remove(at: index)
            entity.delete()
        }
    }
}

//#Preview {
//    @Previewable var sourceAuthors = SourceEntity<Author>(source: .example, entity: .example, appearance: .present)
//    @Previewable @State var examples = sourceAuthors.examples
//    ExpandedSourceAuthorsView(sourceAuthors: $examples)
//}
