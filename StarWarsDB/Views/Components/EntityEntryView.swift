import SwiftUI

struct EntityEntryView<T: TrackableEntity>: View {
    var sourceEntity: SourceEntity<T>

    var body: some View {
        HStack(spacing: Constants.Spacing.sm) {
            CDNImageView(primaryID: sourceEntity.entity.id)
                .frame(width: 40, height: 40)
                .clipShape(.circle)
                .overlay(Circle().strokeBorder(sourceEntity.appearance.color.opacity(0.5), lineWidth: 2))

            Text(sourceEntity.entity.name)
                .foregroundStyle(sourceEntity.number > 1 ? .primary : .secondary)
                .font(sourceEntity.number > 1 ? .body : .subheadline)
                .lineLimit(2)

            Spacer()

            AppearanceView(appearance: sourceEntity.appearance)
        }
    }
}

#Preview {
    let sourceEntity = SourceEntity<Droid>(source: .example, entity: Droid.example, appearance: .present)
    EntityEntryView<Droid>(sourceEntity: sourceEntity)
}
