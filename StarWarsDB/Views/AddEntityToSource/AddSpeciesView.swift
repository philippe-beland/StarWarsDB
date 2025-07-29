import SwiftUI

struct AddSpeciesView: View, AddEntityView {
    typealias EntityType = Species
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
    @State private var homeworld: Planet?
    @State private var firstAppearance: String = ""
    @State private var comments: String = ""
    
    var onAdd: (Species) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding(Constants.Spacing.md)
                Form {
                    Section("Species Infos") {
                        EditableLinkedEntityField(
                            fieldName: "Homeworld",
                            entity: Binding(
                                get: {homeworld ?? Planet.empty },
                                set: {homeworld = ($0 ) }),
                            )
                        EditableTextField(fieldName: "First Appearance", info: $firstAppearance)
                    }
                    CommentsView(comments: $comments)
                    
                    Section {
                        Button("Save", action: saveSpecies)
                            .disabled(name.isEmpty)
                    }
                }
            }
        }
        .navigationTitle("Add new Species")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveSpecies() {
        let newSpecies = Species(name: name, homeworld: homeworld, firstAppearance: firstAppearance, comments: comments)
        newSpecies.save()
        onAdd(newSpecies)
        dismiss()
    }
}

#Preview {
    AddSpeciesView(onAdd: { _ in })
}
