import SwiftUI

struct AddOrganizationView: View, AddEntityView {
    typealias EntityType = Organization
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
    @State private var firstAppearance: String = ""
    @State private var comments: String = ""
    
    var onAdd: (Organization) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding(Constants.Spacing.md)
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
        onAdd(newOrganization)
        dismiss()
    }
}

#Preview {
    AddOrganizationView(onAdd: { _ in })
}
