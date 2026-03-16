import SwiftUI

struct SidePanelView<Content: View>: View {
    var id: UUID
    @Binding var comments: String
    var description: String
    var InfosSection: Content

    var body: some View {
        Form {
            Section {
                CDNImageView(primaryID: id)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .clipShape(.rect(cornerRadius: Constants.CornerRadius.lg))
                    .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            }

            if !description.isEmpty {
                Section("Description") {
                    Text(description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            InfosSection

            CommentsView(comments: $comments)
        }
        .formStyle(.grouped)
    }
}

#Preview {
    @Previewable @State var comments: String = "This is a comment"
    SidePanelView(id: Character.example.id, comments: $comments, description: "This is a fake description", InfosSection: Text(Character.example.name))
}
