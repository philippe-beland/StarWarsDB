import SwiftUI

struct SourceEntityExpandedView<T: TrackableEntity>: View {
    @Binding var sourceEntities: [SourceEntity<T>]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedEntities) { sourceEntity in
                    EntityExpandedRow(sourceEntity: sourceEntity)
                }
                .onDelete { indexSet in
                    let toDelete = indexSet.map { sortedEntities[$0] }
                    toDelete.forEach { entity in
                        entity.delete()
                    }
                    let toDeleteIDs = toDelete.map { $0.id }
                    sourceEntities.removeAll { toDeleteIDs.contains($0.id) }
                }
            }
            .navigationTitle(T.displayName)
        }
    }
    
    private var sortedEntities: [SourceEntity<T>] {
        sourceEntities.sorted(by: { $0.entity.name < $1.entity.name })
    }
}

struct EntityExpandedRow<T: TrackableEntity>: View {
    @Bindable var sourceEntity: SourceEntity<T>
    
    var body: some View {
        VStack(alignment: .leading) {
            EntityEntryView(sourceEntity: sourceEntity)
            
        }
        .contextMenu {
            ForEach(AppearanceType.allCases, id: \.self) { appearance in
                Button(appearance.description) {
                    sourceEntity.appearance = appearance
                    Task { await sourceEntity.update() }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var sourceEntities = [SourceEntity<Species>(source: .example, entity: Species.example, appearance: .present)]
    SourceEntityExpandedView<Species>(sourceEntities: $sourceEntities)
}
