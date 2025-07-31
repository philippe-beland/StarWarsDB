import SwiftUI

struct AddStarshipView: View, AddEntityView {
    typealias EntityType = Starship
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
    @State private var model: StarshipModel = .empty
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
                        EditableLinkedEntityField(entity: $model)
                        EditableTextField(fieldName: "First Appearance", info: $firstAppearance)
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
