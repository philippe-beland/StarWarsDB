import SwiftUI

struct AddStarshipView: View, AddEntityView {
    typealias EntityType = Starship
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
    @State private var model: StarshipModel?
    @State private var firstAppearance: String = ""
    @State private var comments: String = ""
    
    var onAdd: (Starship) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding(Constants.Spacing.md)
                Form {
                    Section("Starship Infos") {
                        EntityInfoEditView(
                            fieldName: "Model",
                            entity: Binding(
                                get: {model ?? StarshipModel.empty },
                                set: {model = ($0 ) }),
                            )
                        FieldView(fieldName: "First Appearance", info: $firstAppearance)
                    }
                    CommentsView(comments: $comments)
                    
                    Section {
                        Button("Save", action: saveStarship)
                            .disabled(name.isEmpty)
                    }
                }
            }
        }
        .navigationTitle("Add new Starship")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveStarship() {
        let newStarship = Starship(name: name, model: model, firstAppearance: firstAppearance, comments: comments)
        newStarship.save()
        onAdd(newStarship)
        dismiss()
    }
}

#Preview {
    AddStarshipView(onAdd: { _ in })
}
