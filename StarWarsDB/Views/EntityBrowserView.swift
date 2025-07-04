import SwiftUI

struct EntityBrowserView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    ForEach(EntityType.sourceTypes) { entityType in
                        NavigationLink(destination: EntitiesListView(entityType: entityType)) {
                            HStack {
                                Image(entityType.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    
                                Text(entityType.displayName)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Entities")
        }
    }
}

#Preview {
    EntityBrowserView()
}
