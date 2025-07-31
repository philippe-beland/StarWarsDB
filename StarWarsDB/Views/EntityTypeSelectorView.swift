import SwiftUI

struct EntityTypeSelectorImageView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: Constants.Layout.entityImageSize, height: Constants.Layout.entityImageSize)
            .clipShape(Circle())
    }
}

struct EntityTypeSelectorView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // Characters
                    NavigationLink(destination: EntityListBrowserView<Character>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Character.displayName)
                            Text(Character.displayName)
                        }
                    }
                    
                    // Species
                    NavigationLink(destination: EntityListBrowserView<Species>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Species.displayName)
                            Text(Species.displayName)
                        }
                    }
                    
                    // Planets
                    NavigationLink(destination: EntityListBrowserView<Planet>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Planet.displayName)
                            Text(Planet.displayName)
                        }
                    }
                    
                    // Organizations
                    NavigationLink(destination: EntityListBrowserView<Organization>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Organization.displayName)
                            Text(Organization.displayName)
                        }
                    }
                    
                    // Starships
                    NavigationLink(destination: EntityListBrowserView<Starship>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Starship.displayName)
                            Text(Starship.displayName)
                        }
                    }
                    
                    // Starship Models
                    NavigationLink(destination: EntityListBrowserView<StarshipModel>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: StarshipModel.displayName)
                            Text(StarshipModel.displayName)
                        }
                    }
                    
                    
                    // Creatures
                    NavigationLink(destination: EntityListBrowserView<Creature>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Creature.displayName)
                            Text(Creature.displayName)
                        }
                    }

                    // Droids
                    NavigationLink(destination: EntityListBrowserView<Droid>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Droid.displayName)
                            Text(Droid.displayName)
                        }
                    }

                    // Miscellaneous
                    NavigationLink(destination: EntityListBrowserView<Misc>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Misc.displayName)
                            Text(Misc.displayName)
                        }
                    }
                }
            }
            .navigationTitle("Entities")
        }
    }
}

#Preview {
    EntityTypeSelectorView()
}
