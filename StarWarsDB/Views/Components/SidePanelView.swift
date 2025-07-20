import SwiftUI

struct SidePanelView<Content: View>: View {
    var id: UUID
    @Binding var comments: String
    var InfosSection: Content
    
    var body: some View {
        Form {
            ImageView(title: id.uuidString.lowercased())
            InfosSection
            CommentsView(comments: $comments)
        }
    }
}

#Preview {
    @Previewable @State var comments: String = "This is a comment"
    SidePanelView(id: Character.example.id, comments: $comments, InfosSection: Text(Character.example.name))
}
