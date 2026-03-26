import SwiftUI

struct AddAuthorView: View, AddEntityView {
    typealias EntityType = Author
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
    @State private var comments: String = ""
    
    var onAdd: (Author) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .font(.title.bold())
                }
                CommentsView(comments: $comments)
                
                Section {
                    Button("Save", action: saveAuthor)
                        .disabled(name.isEmpty)
                }
            }
            .navigationTitle("Add new Author")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func saveAuthor() {
        let newAuthor = Author(name: name, comments: comments)
        newAuthor.save()
        onAdd(newAuthor)
        dismiss()
    }
}

#Preview {
    AddAuthorView(onAdd: { _ in })
}
