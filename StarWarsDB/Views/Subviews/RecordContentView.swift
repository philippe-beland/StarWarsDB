import SwiftUI

struct EntityContentView<Content: View>: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Bindable var entity: Entity
    
    var sourceEntities: [SourceEntity]
    var InfosSection: Content
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(name: $entity.name, url: entity.url)
            
            if horizontalSizeClass == .regular {
                HStack {
                    SidePanelView(entity: entity, InfosSection: InfosSection)
                        .frame(width: 350)
                    Spacer()
                    SourcesSection(sourceEntities: sourceEntities)
                }
            } else {
                VStack {
                    SidePanelView(entity: entity, InfosSection: InfosSection)
                    Spacer()
                    SourcesSection(sourceEntities: sourceEntities)
                }
            }
        }
    }
}

//#Preview {
//    EntityContentView(entity: Character.example, sourceEntities: SourceCharacter.example, InfosSection: Text(Character.example.name))
//}
