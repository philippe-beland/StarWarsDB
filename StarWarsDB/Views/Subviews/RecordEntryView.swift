import SwiftUI

struct EntityEntryView: View {
    var sourceEntity: SourceEntity
    
    var body: some View {
        HStack {
            imageOrPlaceholder(for: sourceEntity.entity.id)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50, alignment: .top)
                .clipShape(Circle())
                .foregroundStyle(.secondary)
            
            Text(sourceEntity.entity.name)
                .foregroundStyle(sourceEntity.number > 1 ? .primary :.secondary)
                .font(sourceEntity.number > 1 ? .body : .subheadline)
            Spacer()
            AppearanceView(appearance: sourceEntity.appearance.rawValue)
            
        }
    }
}
