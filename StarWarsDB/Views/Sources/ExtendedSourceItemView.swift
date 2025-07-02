import SwiftUI

struct ExpandedSourceItemView: View {
    @Binding var sourceItems: [SourceItem]
    var entityType: EntityType
    @State private var refreshID = UUID()
    
    private var sortedEntities: [SourceItem] {
        sourceItems.sorted(by: { $0.entity.name < $1.entity.name })
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedEntities) { sourceItem in
                    RecordEntryView(sourceItem: sourceItem)
                        .id(refreshID)
                        .contextMenu {
                            appearanceContextMenu(for: sourceItem)
                        }
                }
                .onDelete(perform: deleteEntity)
            }
            .navigationTitle(entityType.rawValue)
        }
    }
    
    private func appearanceContextMenu(for sourceItem: SourceItem) -> some View {
        Group {
            ForEach(AppearanceType.allCases, id: \.self) { appearance in
                Button(appearance.description) {
                    updateAppearance(of: sourceItem, to: appearance)
                }
            }
        }
    }
    
    private func updateAppearance(of sourceItem: SourceItem, to appearance: AppearanceType) {
        if let index = sourceItems.firstIndex(where: { $0.id == sourceItem.id }) {
            sourceItems[index].appearance = appearance
            sourceItem.update()
            refreshID = UUID()
        }
    }
    
    private func deleteEntity(_ indexSet: IndexSet) {
        for index: IndexSet.Element in indexSet {
            let entity = sortedEntities[index]
            if let indexofSource = sourceItems.firstIndex(of: entity) {
                sourceItems.remove(at: indexofSource)
            }
            entity.delete()
        }
    }
}
