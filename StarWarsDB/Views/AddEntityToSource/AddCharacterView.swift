import SwiftUI

struct AddCharacterView: View, AddEntityView {
    typealias EntityType = Character
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
    @State private var aliases: [String] = []
    @State private var species: Species = .empty
    @State private var homeworld: Planet = .empty
    @State private var gender: Gender = .Unknown
    //@State private var affiliations: [Organization] = []
    @State private var firstAppearance: String = ""
    @State private var comments: String = ""
    
    var onAdd: (Character) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding(Constants.Spacing.md)
                Form {
                    Section("Character Infos") {
                        //MultiFieldView(fieldName: "Aliases", infos: aliases)
                        GenderPicker(gender: $gender)
                        EditableLinkedEntityField(entity: $species)
                        EditableLinkedEntityField(entity: $homeworld)
                        //MultiFieldView(fieldName: "Affiliation", entities: affiliations)
                        EditableTextField(fieldName: "First Appearance", info: $firstAppearance)
                    }
                    CommentsView(comments: $comments)
                    
                    Section {
                        Button("Save", action: saveCharacter)
                            .disabled(name.isEmpty)
                    }
                }
            }
        }
        .navigationTitle("Add new Character")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveCharacter() {
        let newCharacter = Character(name: name, aliases: aliases, species: species, homeworld: homeworld, gender: gender, firstAppearance: firstAppearance, comments: comments)
        newCharacter.save()
        onAdd(newCharacter)
        dismiss()
    }
}

#Preview {
    AddCharacterView(onAdd: { _ in })
}
