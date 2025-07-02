import SwiftUI

struct SidePanelView<Content: View>: View {
    @Bindable var record: Entity
    var InfosSection: Content
    
    var body: some View {
        Form {
            ImageView(title: record.id.uuidString.lowercased())
            InfosSection
            FieldView(fieldName: "URL", info: $record.wookieepediaTitle)
            CommentsView(comments: $record.comments)
        }
    }
}

//#Preview {
//    SidePanelView(record: Character.example, InfosSection: Text(Character.example.name))
//}
