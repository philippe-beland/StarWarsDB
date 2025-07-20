import SwiftUI

struct AddArcView: View, AddEntityView {
    typealias EntityType = Arc
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
    @State private var comments: String = ""
    @State private var serie: Serie = .empty

    var onAdd: (Arc) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding()
                Form {
//                    EntityInfoEditView<Serie>(
//                        fieldName: "Serie",
//                        entity: Binding(
//                            get: {serie },
//                            set: {serie = ($0 ) }),
//                        )
                    
                    CommentsView(comments: $comments)
                    
                    Section {
                        Button("Save", action: saveArc)
                            .disabled(name.isEmpty)
                    }
                }
            }
        }
        .navigationTitle("Add new Arc")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveArc() {
        let newArc = Arc(name: name, serie: serie, comments: comments)
        newArc.save()
        onAdd(newArc)
        dismiss()
    }
}

#Preview {
    AddArcView(onAdd: { _ in })
}
