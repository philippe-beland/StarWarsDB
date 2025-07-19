import SwiftUI

struct EntityBrowserImageView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
    }
}

struct EntityBrowserView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // Characters
                    NavigationLink(destination: EntitiesListView<Character>()) {
                        HStack {
                            EntityBrowserImageView(imageName: Character.exampleImageName)
                            Text(Character.displayName)
                        }
                    }
                    
                    // Species
                    NavigationLink(destination: EntitiesListView<Species>()) {
                        HStack {
                            EntityBrowserImageView(imageName: Species.exampleImageName)                           
                            Text(Species.displayName)
                        }
                    }
                    
                    // Planets
                    NavigationLink(destination: EntitiesListView<Planet>()) {
                        HStack {
                            EntityBrowserImageView(imageName: Planet.exampleImageName)
                            Text(Planet.displayName)
                        }
                    }
                    
                    // Organizations
                    NavigationLink(destination: EntitiesListView<Organization>()) {
                        HStack {
                            EntityBrowserImageView(imageName: Organization.exampleImageName)
                            Text(Organization.displayName)
                        }
                    }
                    
                    // Starships
                    NavigationLink(destination: EntitiesListView<Starship>()) {
                        HStack {
                            EntityBrowserImageView(imageName: Starship.exampleImageName)
                            Text(Starship.displayName)
                        }
                    }
                    
                    // Starship Models
                    NavigationLink(destination: EntitiesListView<StarshipModel>()) {
                        HStack {
                            EntityBrowserImageView(imageName: StarshipModel.exampleImageName)
                            Text(StarshipModel.displayName)
                        }
                    }
                    
                    
                    // Creatures
                    NavigationLink(destination: EntitiesListView<Creature>()) {
                        HStack {
                            EntityBrowserImageView(imageName: Creature.exampleImageName)
                            Text(Creature.displayName)
                        }
                    }

                    // Droids
                    NavigationLink(destination: EntitiesListView<Droid>()) {
                        HStack {
                            EntityBrowserImageView(imageName: Droid.exampleImageName)
                            Text(Droid.displayName)
                        }
                    }

                    // Varias
                    NavigationLink(destination: EntitiesListView<Varia>()) {
                        HStack {
                            EntityBrowserImageView(imageName: Varia.exampleImageName)
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
    EntityBrowserView()
}
