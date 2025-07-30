import SwiftUI

struct EntityEntryView<T: TrackableEntity>: View {
    var sourceEntity: SourceEntity<T>
    
    var body: some View {
        HStack {
            imageOrPlaceholder(for: sourceEntity.entity.id, size:50)
            
            Text(sourceEntity.entity.name)
                .foregroundStyle(sourceEntity.number > 1 ? .primary :.secondary)
                .font(sourceEntity.number > 1 ? .body : .subheadline)
            Spacer()
            AppearanceView(appearance: sourceEntity.appearance.rawValue)
            
        }
    }
}

//#Preview {
//    let sourceEntity: SourceEntity<Droid> = SourceEntity(source: .example, entity: Droid.example, appearance: .present)
//    EntityEntryView<Droid>(sourceEntity: sourceEntity.example)
//}
