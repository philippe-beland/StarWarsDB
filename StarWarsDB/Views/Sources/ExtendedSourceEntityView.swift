import SwiftUI

struct ExpandedSourceEntityView<T: Entity>: View {
    @Binding var sourceEntities: [SourceEntity<T>]
    @State private var refreshID = UUID()
    
    private var sortedEntities: [SourceEntity<T>] {
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
            .navigationTitle(T.displayName)
        }
    }
    
    private func appearanceContextMenu(for sourceEntity: SourceEntity<T>) -> some View {
        Group {
            ForEach(AppearanceType.allCases, id: \.self) { appearance in
                Button(appearance.description) {
                    updateAppearance(of: sourceEntity, to: appearance)
                }
            }
        }
    }
    
    private func updateAppearance(of sourceEntity: SourceEntity<T>, to appearance: AppearanceType) {
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

//#Preview {
//    @Previewable var sourceEntities = SourceEntity<Species>(source: .example, entity: Species.example, appearance: .present)
//    @Previewable @State var examples: [SourceEntity<Species>] = sourceEntities.examples
//    ExpandedSourceEntityView<Species>(sourceEntities: $examples)
//}
