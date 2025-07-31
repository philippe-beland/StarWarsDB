import SwiftUI

struct SidePanelView<Content: View>: View {
    var id: UUID
    @Binding var comments: String
    var description: String
    var InfosSection: Content
    
    var body: some View {
        Form {
            CDNImageView(primaryID: id)
            Section("Description") {
                Text(description)
            }
            InfosSection
            CommentsView(comments: $comments)
        }
    }
}

#Preview {
    @Previewable @State var comments: String = "This is a comment"
    SidePanelView(id: Character.example.id, comments: $comments, description: " This is a fake description", InfosSection: Text(Character.example.name))
}
