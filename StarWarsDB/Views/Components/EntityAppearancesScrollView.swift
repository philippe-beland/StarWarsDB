import SwiftUI

struct EntityAppearancesScrollView<T: TrackableEntity>: View {
    var sourceEntities: [SourceEntity<T>]

    private static var layout: [GridItem] {
        [GridItem(.adaptive(minimum: 240), spacing: Constants.Spacing.sm)]
    }

    private var sortedEntities: [SourceEntity<T>] {
        sourceEntities.sorted { $0.entity.name < $1.entity.name }
    }

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Self.layout, spacing: 2) {
                ForEach(sortedEntities) { sourceEntity in
                    NavigationLink(destination: EntityDetailRouter<T>(entity: sourceEntity.entity)) {
                        EntityEntryView(sourceEntity: sourceEntity)
                            .padding(.vertical, 6)
                            .padding(.horizontal, Constants.Spacing.sm)
                            .background(.fill.quinary, in: .rect(cornerRadius: Constants.CornerRadius.md))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.top, Constants.Spacing.sm)
    }
}

#Preview {
    let sourceEntities = SourceEntity<Character>(source: .example, entity: .example, appearance: .present)
    let examples: [SourceEntity<Character>] = [sourceEntities]
    EntityAppearancesScrollView<Character>(sourceEntities: examples)
}
