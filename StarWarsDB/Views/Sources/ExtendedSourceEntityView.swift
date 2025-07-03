import SwiftUI

struct ExpandedSourceEntityView: View {
    @Binding var sourceEntities: [SourceEntity]
    var entityType: EntityType
    @State private var refreshID = UUID()
    
    private var sortedEntities: [SourceEntity] {
        sourceEntities.sorted(by: { $0.entity.name < $1.entity.name })
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedEntities) { sourceEntity in
                    EntityEntryView(sourceEntity: sourceEntity)
                        .id(refreshID)
                        .contextMenu {
                            appearanceContextMenu(for: sourceEntity)
                        }
                }
                .onDelete(perform: deleteEntity)
            }
            .navigationTitle(entityType.rawValue)
        }
    }
    
    private func appearanceContextMenu(for sourceEntity: SourceEntity) -> some View {
        Group {
            ForEach(AppearanceType.allCases, id: \.self) { appearance in
                Button(appearance.description) {
                    updateAppearance(of: sourceEntity, to: appearance)
                }
            }
        }
    }
    
    private func updateAppearance(of sourceEntity: SourceEntity, to appearance: AppearanceType) {
        if let index = sourceEntities.firstIndex(where: { $0.id == sourceEntity.id }) {
            sourceEntities[index].appearance = appearance
            sourceEntity.update()
            refreshID = UUID()
        }
    }
    
    private func deleteEntity(_ indexSet: IndexSet) {
        for index: IndexSet.Element in indexSet {
            let entity = sortedEntities[index]
            if let indexofSource = sourceEntities.firstIndex(of: entity) {
                sourceEntities.remove(at: indexofSource)
            }
            entity.delete()
        }
    }
}
