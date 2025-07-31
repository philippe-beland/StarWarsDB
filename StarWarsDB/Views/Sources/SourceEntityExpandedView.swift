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
                    let toDelete = indexSet.map { sortedEntities[$0].id }
                    sourceEntities.removeAll { toDelete.contains($0.id) }
                    toDelete.forEach { id in
                        if let deleted = sourceEntities.first(where: { $0.id == id }) {
                            deleted.delete()
                        }
                    }
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
