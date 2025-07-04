import SwiftUI

struct EntityDetailContentView<Content: View>: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Bindable var entity: Entity
    
    var sourceEntities: [SourceEntity]
    var InfosSection: Content
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(name: $entity.name, url: entity.url)
            
            GeometryReader { geometry in
                let isLandscape = geometry.size.width > geometry.size.height
                let isPad = UIDevice.current.userInterfaceIdiom == .pad
                
#if os(macOS)
                let isTarget = true
#else
                let isTarget = isPad && isLandscape
#endif
                
                Group {
                    if isTarget {
                        HStack {
                            SidePanelView(entity: entity, InfosSection: InfosSection)
                                .frame(width: 350)
                            Spacer()
                            SourcesSection(sourceEntities: sourceEntities)
                        }
                    } else {
                        TabView {
                            SourcesSection(sourceEntities: sourceEntities)
                                .tabItem {
                                    Text("Sources")
                                }
                            SidePanelView(entity: entity, InfosSection: InfosSection)
                                .tabItem {
                                    Text("Infos")
                                }
                        }.tabViewStyle(.page)
                    }
                }
            }
        }
    }
}

#Preview {
    EntityDetailContentView(entity: Character.example, sourceEntities: SourceCharacter.example, InfosSection: Text(Character.example.name))
}
