import SwiftUI

struct AddCreatureView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
    @State private var designation: String = ""
    @State private var homeworld: Planet?
    @State private var firstAppearance: String = ""
    @State private var comments: String = ""
    
    var onCreatureCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding()
                Form {
                    Section("Creature Infos") {
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
                        Button("Save", action: saveCreature)
                            .disabled(name.isEmpty)
                    }
                }
            }
        }
        .navigationTitle("Add new Creature")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveCreature() {
        let newCreature = Creature(name: name, designation: designation, homeworld: homeworld, firstAppearance: firstAppearance, comments: comments)
        newCreature.save()
        onCreatureCreation(newCreature)
        dismiss()
    }
}

#Preview {
    AddCreatureView(onCreatureCreation: { _ in })
}
