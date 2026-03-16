import SwiftUI

struct EntityDetailContentView<T: TrackableEntity, Header: View, SidePanel: View>: View {

    enum Tab: Hashable { case sources, info }
    @State private var selectedTab: Tab = .info

    let headerSection: Header
    let sidePanel: SidePanel
    let sourceEntities: [SourceEntity<T>]

    init(
        headerSection: Header,
        sidePanel: SidePanel,
        sourceEntities: [SourceEntity<T>]
    ) {
        self.headerSection = headerSection
        self.sidePanel = sidePanel
        self.sourceEntities = sourceEntities
    }

    var body: some View {
        ViewThatFits(in: .horizontal) {
            splitLayout
            tabLayout
        }
    }

    // MARK: - Wide layout (side-by-side)

    private var splitLayout: some View {
        VStack(spacing: 0) {
            headerSection
                .padding(.horizontal, Constants.Spacing.md)
                .padding(.vertical, Constants.Spacing.sm)

            HStack(spacing: 0) {
                sidePanel
                    .frame(width: Constants.Layout.sidePanelWidth)
                    .frame(maxHeight: .infinity, alignment: .top)

                Divider()

                SourcesSectionView<T>(sourceEntities: sourceEntities)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
        .background(Color(.systemGroupedBackground))
        .frame(minWidth: 720)
    }

    // MARK: - Narrow layout (segmented picker)

    private var tabLayout: some View {
        VStack(spacing: 0) {
            headerSection
                .padding(.horizontal, Constants.Spacing.md)
                .padding(.vertical, Constants.Spacing.sm)

            Picker("Section", selection: $selectedTab) {
                Label("Info", systemImage: "info.circle").tag(Tab.info)
                Label("Sources", systemImage: "doc.text").tag(Tab.sources)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, Constants.Spacing.md)
            .padding(.bottom, Constants.Spacing.sm)

            switch selectedTab {
            case .sources:
                SourcesSectionView<T>(sourceEntities: sourceEntities)
            case .info:
                sidePanel
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    @Previewable @State var character = Character.example
    let sourceEntity: SourceEntity<Character> = SourceEntity(
        source: .example,
        entity: Character.example,
        appearance: .present
    )

    EntityDetailContentView(
        headerSection: SectionHeaderView(
            name: $character.name,
            url: character.url
        ),
        sidePanel: SidePanelView(
            id: character.id,
            comments: Binding(
                get: { character.comments ?? "" },
                set: { character.comments = $0.isEmpty ? nil : $0 }
            ),
            description: "This is a fake description",
            InfosSection: CharacterInfoSection(character: character)
        ),
        sourceEntities: [sourceEntity]
    )
}
