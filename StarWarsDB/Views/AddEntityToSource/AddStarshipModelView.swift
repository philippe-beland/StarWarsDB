import SwiftUI

struct AddStarshipModelView: View, AddEntityView {
    typealias EntityType = StarshipModel
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
    @State private var classType: String = ""
    @State private var line: String = ""
    @State private var firstAppearance: String = ""
    @State private var comments: String = ""
    
    var onAdd: (StarshipModel) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding()
                Form {
                    Section("Starship Model Infos") {
                        FieldView(fieldName: "Class Type", info: $classType)
                        FieldView(fieldName: "Line", info: $line)
                        FieldView(fieldName: "First Appearance", info: $firstAppearance)
                    }
                    CommentsView(comments: $comments)
                    
                    Section {
                        Button("Save", action: saveStarshipModel)
                            .disabled(name.isEmpty)
                    }
                }
            }
        }
        .navigationTitle("Add new Starship Model")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveStarshipModel() {
        let newStarshipModel = StarshipModel(name: name, classType: classType, line: line, firstAppearance: firstAppearance, comments: comments)
        newStarshipModel.save()
        onAdd(newStarshipModel)
        dismiss()
    }
}

#Preview {
    AddStarshipModelView(onAdd: { _ in })
}
