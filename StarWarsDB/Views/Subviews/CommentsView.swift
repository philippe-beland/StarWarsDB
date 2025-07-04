import SwiftUI

struct CommentsView: View {
    @Binding var comments: String
    
    var body: some View {
        Section("Comments") {
            TextEditor(text: $comments)
        }
    }
}

#Preview {
    CommentsView(comments: "Hello World!")
}
