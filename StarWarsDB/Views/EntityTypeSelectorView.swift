import SwiftUI

struct EntityTypeSelectorView: View {
    var body: some View {
        NavigationStack {
            List {
                EntityTypeRow<Character>()
                EntityTypeRow<Species>()
                EntityTypeRow<Planet>()
                EntityTypeRow<Organization>()
                EntityTypeRow<Starship>()
                EntityTypeRow<StarshipModel>()
                EntityTypeRow<Creature>()
                EntityTypeRow<Droid>()
                EntityTypeRow<Misc>()
            }
            .navigationTitle("Entities")
        }
    }
}

private struct EntityTypeRow<T: TrackableEntity>: View {
    var body: some View {
        NavigationLink(destination: EntityListBrowserView<T>()) {
            Label {
                Text(T.displayName)
            } icon: {
                Image(T.displayName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.Layout.entityImageSize, height: Constants.Layout.entityImageSize)
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    EntityTypeSelectorView()
}
