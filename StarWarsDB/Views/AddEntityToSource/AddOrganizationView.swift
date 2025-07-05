import SwiftUI

struct AddOrganizationView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
    @State private var firstAppearance: String = ""
    @State private var comments: String = ""
    
    var onOrganizationCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding()
                Form {
                    Section("Organization Infos") {
                        FieldView(fieldName: "First Appearance", info: $firstAppearance)
                    }
                    CommentsView(comments: $comments)
                    
                    Section {
                        Button("Save", action: saveOrganization)
                            .disabled(name.isEmpty)
                    }
                }
            }
        }
        .navigationTitle("Add new Organization")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveOrganization() {
        let newOrganization = Organization(name: name, firstAppearance: firstAppearance, comments: comments)
        newOrganization.save()
        onOrganizationCreation(newOrganization)
        dismiss()
    }
}

#Preview {
    AddOrganizationView(onOrganizationCreation: { _ in })
}
