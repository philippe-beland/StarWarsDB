import SwiftUI

struct AddSerieView: View, AddEntityView {
    typealias EntityType = Serie
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
    @State private var sourceType: SourceType = .comics
    @State private var comments: String = ""
    
    var onAdd: (Serie) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding(Constants.Spacing.md)
                Form {
                    SourceTypePicker(sourceType: $sourceType)
                    CommentsView(comments: $comments)
                    
                    Section {
                        Button("Save", action: saveSerie)
                            .disabled(name.isEmpty)
                    }
                }
            }
        }
        .navigationTitle("Add new Serie")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveSerie() {
        let newSerie = Serie(name: name, sourceType: sourceType, comments: comments)
        newSerie.save()
        onAdd(newSerie)
        dismiss()
    }
}

#Preview {
    AddSerieView(onAdd: { _ in })
}
