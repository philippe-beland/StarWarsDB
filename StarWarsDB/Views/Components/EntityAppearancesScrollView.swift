import SwiftUI

struct EntityAppearancesScrollView<T: Entity>: View {
    @Binding var sourceEntities: [SourceEntity<T>]
    let layout = [GridItem(.adaptive(minimum: 225), spacing: 24)]
    
    private var sortedEntities: [SourceEntity<T>] {
        sourceEntities.sorted(by: { $0.entity.name < $1.entity.name })
    }

    var body: some View {
            ScrollView(.vertical) {
                LazyVGrid (columns: layout, spacing: 40) {
                    ForEach(sortedEntities) { sourceEntity in
                        NavigationLink(destination: EntityDetailRouter<T>(entity: sourceEntity.entity)) {
                            EntityEntryView(sourceEntity: sourceEntity)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding(.vertical)
        }
}

//#Preview {
//    @Previewable var sourceEntities = SourceEntity<Character>(source: .example, entity: .example, appearance: .present)
//    @Previewable @State var examples: [SourceEntity<Character>] = sourceEntities.examples
//    EntityAppearancesScrollView<Character>(sourceEntities: $examples)
//}
