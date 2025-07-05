import SwiftUI

struct EntityEntryView: View {
    var sourceEntity: SourceEntity
    
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

#Preview {
    EntityEntryView(sourceEntity: SourceDroid.example[0])
}
