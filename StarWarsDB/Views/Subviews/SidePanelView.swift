import SwiftUI

struct SidePanelView<Content: View>: View {
    @Bindable var entity: Entity
    var InfosSection: Content
    
    var body: some View {
        Form {
            ImageView(title: entity.id.uuidString.lowercased())
            InfosSection
            FieldView(fieldName: "URL", info: $entity.wookieepediaTitle)
            CommentsView(comments: $entity.comments)
        }
    }
}

//#Preview {
//    SidePanelView(entity: Character.example, InfosSection: Text(Character.example.name))
//}
