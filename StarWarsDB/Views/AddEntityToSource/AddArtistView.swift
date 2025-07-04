import SwiftUI

struct AddArtistView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
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

#Preview {
    AddArtistView()
}
