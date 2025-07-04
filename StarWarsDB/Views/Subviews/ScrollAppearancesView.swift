import SwiftUI

struct ScrollAppearancesView<T: SourceEntity>: View {
    @Binding var sourceEntities: [T]
    
    let entityType: EntityType
    let layout = [GridItem(.adaptive(minimum: 225), spacing: 24)]
    
    private var sortedEntities: [SourceEntity] {
        sourceEntities.sorted(by: { $0.entity.name < $1.entity.name })
    }

    var body: some View {
            ScrollView(.vertical) {
                LazyVGrid (columns: layout, spacing: 40) {
                    ForEach(sortedEntities) { sourceEntity in
                        NavigationLink(destination: EntityDetailView(entityType: entityType, entity: sourceEntity.entity)) {
                            EntityEntryView(sourceEntity: sourceEntity)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding(.vertical)
        }
}

#Preview {
    ScrollAppearancesView(sourceEntities: $SourceCharacter.example, entityType: .character)
}
