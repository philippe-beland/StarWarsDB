import SwiftUI

struct AddDroidView: View, AddEntityView {
    typealias EntityType = Droid
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
    @State private var classType: String = ""
    @State private var firstAppearance: String = ""
    @State private var comments: String = ""
    
    var onAdd: (Droid) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding()
                
                Form {
                    Section("Droid Infos") {
                        FieldView(fieldName: "Class Type", info: $classType)
                        FieldView(fieldName: "First Appearance", info: $firstAppearance)
                    }
                    CommentsView(comments: $comments)
                    
                    Section {
                        Button("Save", action: saveDroid)
                            .disabled(name.isEmpty)
                    }
                }
            }
        }
        .navigationTitle("Add new Droid")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveDroid() {
        let newDroid = Droid(name: name, classType: classType, firstAppearance: firstAppearance, comments: comments)
        newDroid.save()
        onAdd(newDroid)
        dismiss()
    }
}

#Preview {
    AddDroidView(onAdd: { _ in })
}
