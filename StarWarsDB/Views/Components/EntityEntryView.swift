import SwiftUI

struct EntityEntryView<T: TrackableEntity>: View {
    var sourceEntity: SourceEntity<T>
    
    var body: some View {
        HStack {
            CDNImageView(primaryID: sourceEntity.entity.id)
                .frame(width: 50, height: 50, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: Constants.CornerRadius.sm))
                .shadow(radius: 5)
            
            Text(sourceEntity.entity.name)
                .foregroundStyle(sourceEntity.number > 1 ? .primary :.secondary)
                .font(sourceEntity.number > 1 ? .body : .subheadline)
            Spacer()
            AppearanceView(appearance: sourceEntity.appearance)
        }
    }
}

//#Preview {
//    let sourceEntity: SourceEntity<Droid> = SourceEntity(source: .example, entity: Droid.example, appearance: .present)
//    EntityEntryView<Droid>(sourceEntity: sourceEntity.example)
//}
