import SwiftUI

struct AddArcView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String
    @State private var comments: String = ""
    @State private var serie: Serie = .empty
    
    var onArcCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding()
                Form {
                    EditEntityInfoView(
                        fieldName: "Serie",
                        entity: Binding(
                            get: {serie },
                            set: {serie = ($0 as! Serie) }),
                        entityType: .serie)
                    
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
        onArcCreation(newArc)
        dismiss()
    }
}
