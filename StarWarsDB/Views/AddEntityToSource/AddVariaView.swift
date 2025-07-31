import SwiftUI

struct AddMiscView: View, AddEntityView {
    @Environment(\.dismiss) var dismiss: DismissAction
    typealias EntityType = Misc
    @State var name: String = ""
    @State private var firstAppearance: String = ""
    @State private var comments: String = ""
    
    var onAdd: (Misc) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding(Constants.Spacing.md)
                Form {
                    Section("Misc Infos") {
                        EditableTextField(fieldName: "First Appearance", info: $firstAppearance)
                    }
                    CommentsView(comments: $comments)
                    
                    Section {
                        Button("Save", action: saveMisc)
                            .disabled(name.isEmpty)
                    }
                }
            }
        }
        .navigationTitle("Add new Misc")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveMisc() {
        let newMisc = Misc(name: name, firstAppearance: firstAppearance, comments: comments)
        newMisc.save()
        onAdd(newMisc)
        dismiss()
    }
}

#Preview {
    AddMiscView(onAdd: { _ in })
}
