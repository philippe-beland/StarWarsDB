import SwiftUI

struct AddSpeciesView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
    @State private var homeworld: Planet?
    @State private var firstAppearance: String = ""
    @State private var comments: String = ""
    
    var onSpeciesCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding()
                Form {
                    Section("Species Infos") {
                        EditEntityInfoView(
                            fieldName: "Homeworld",
                            entity: Binding(
                                get: {homeworld ?? Planet.empty },
                                set: {homeworld = ($0 as! Planet) }),
                            entityType: .planet)
                        FieldView(fieldName: "First Appearance", info: $firstAppearance)
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
        onSpeciesCreation(newSpecies)
        dismiss()
    }
}

#Preview {
    AddSpeciesView(onSpeciesCreation: { _ in })
}
