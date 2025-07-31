import SwiftUI

struct EntityDetailContentView<T: TrackableEntity, Header: View, SidePanel: View>: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    var headerSection: Header
    var sidePanel: SidePanel
    
    var sourceEntities: [SourceEntity<T>]
    
    var isSplitLayout: Bool {
#if os(macOS)
        return true
#else
        let isLandscape = UIScreen.main.bounds.width > UIScreen.main.bounds.height
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        return isPad && isLandscape
#endif
    }
    
    var body: some View {
        VStack(spacing: 0) {
            headerSection
            
        if isSplitLayout {
            HStack {
                sidePanel.frame(width: Constants.Layout.sidePanelWidth)
                Spacer()
                SourcesSectionView<T>(sourceEntities: sourceEntities)
            }
        } else {
            TabView {
                SourcesSectionView<T>(sourceEntities: sourceEntities)
                    .tabItem { Text("Sources") }
                sidePanel
                    .tabItem { Text("Infos") }
            }.tabViewStyle(.page)
        }
        }
    }
}

#Preview {
    @Previewable @State var character = Character.example
    let sourceEntity: SourceEntity<Character> = SourceEntity(source: .example, entity: Character.example, appearance: .present)
    let sourceCharacters = [sourceEntity]
    
    EntityDetailContentView(
        headerSection: SectionHeaderView(
            name: $character.name,
            url: character.url
        ),
        sidePanel: SidePanelView(
            id: character.id,
            comments: Binding(
                get: { character.comments ?? "" },
                set: { character.comments = $0 }
            ),
            description: "This is a fake description",
            InfosSection: CharacterInfoSection(character: character)
        ),
        sourceEntities: sourceCharacters)
}
