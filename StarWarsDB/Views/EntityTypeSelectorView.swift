import SwiftUI

struct EntityTypeSelectorImageView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50)
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
                            EntityTypeSelectorImageView(imageName: Character.exampleImageName)
                            Text(Character.displayName)
                        }
                    }
                    
                    // Species
                    NavigationLink(destination: EntityListBrowserView<Species>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Species.exampleImageName)
                            Text(Species.displayName)
                        }
                    }
                    
                    // Planets
                    NavigationLink(destination: EntityListBrowserView<Planet>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Planet.exampleImageName)
                            Text(Planet.displayName)
                        }
                    }
                    
                    // Organizations
                    NavigationLink(destination: EntityListBrowserView<Organization>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Organization.exampleImageName)
                            Text(Organization.displayName)
                        }
                    }
                    
                    // Starships
                    NavigationLink(destination: EntityListBrowserView<Starship>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Starship.exampleImageName)
                            Text(Starship.displayName)
                        }
                    }
                    
                    // Starship Models
                    NavigationLink(destination: EntityListBrowserView<StarshipModel>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: StarshipModel.exampleImageName)
                            Text(StarshipModel.displayName)
                        }
                    }
                    
                    
                    // Creatures
                    NavigationLink(destination: EntityListBrowserView<Creature>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Creature.exampleImageName)
                            Text(Creature.displayName)
                        }
                    }

                    // Droids
                    NavigationLink(destination: EntityListBrowserView<Droid>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Droid.exampleImageName)
                            Text(Droid.displayName)
                        }
                    }

                    // Varias
                    NavigationLink(destination: EntityListBrowserView<Varia>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Varia.exampleImageName)
                            Text(Varia.displayName)
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
