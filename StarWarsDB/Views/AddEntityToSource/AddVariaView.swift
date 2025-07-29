import SwiftUI

struct AddVariaView: View, AddEntityView {
    @Environment(\.dismiss) var dismiss: DismissAction
    typealias EntityType = Varia
    @State var name: String = ""
    @State private var firstAppearance: String = ""
    @State private var comments: String = ""
    
    var onAdd: (Varia) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding(Constants.Spacing.md)
                Form {
                    Section("Varia Infos") {
                        FieldView(fieldName: "First Appearance", info: $firstAppearance)
                    }
                    CommentsView(comments: $comments)
                    
                    Section {
                        Button("Save", action: saveVaria)
                            .disabled(name.isEmpty)
                    }
                }
            }
        }
        .navigationTitle("Add new Varia")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveVaria() {
        let newVaria = Varia(name: name, firstAppearance: firstAppearance, comments: comments)
        newVaria.save()
        onAdd(newVaria)
        dismiss()
    }
}

#Preview {
    AddVariaView(onAdd: { _ in })
}
