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
                    NavigationLink(destination: EntitiesListView<Character>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Character.exampleImageName)
                            Text(Character.displayName)
                        }
                    }
                    
                    // Species
                    NavigationLink(destination: EntitiesListView<Species>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Species.exampleImageName)
                            Text(Species.displayName)
                        }
                    }
                    
                    // Planets
                    NavigationLink(destination: EntitiesListView<Planet>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Planet.exampleImageName)
                            Text(Planet.displayName)
                        }
                    }
                    
                    // Organizations
                    NavigationLink(destination: EntitiesListView<Organization>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Organization.exampleImageName)
                            Text(Organization.displayName)
                        }
                    }
                    
                    // Starships
                    NavigationLink(destination: EntitiesListView<Starship>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Starship.exampleImageName)
                            Text(Starship.displayName)
                        }
                    }
                    
                    // Starship Models
                    NavigationLink(destination: EntitiesListView<StarshipModel>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: StarshipModel.exampleImageName)
                            Text(StarshipModel.displayName)
                        }
                    }
                    
                    
                    // Creatures
                    NavigationLink(destination: EntitiesListView<Creature>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Creature.exampleImageName)
                            Text(Creature.displayName)
                        }
                    }

                    // Droids
                    NavigationLink(destination: EntitiesListView<Droid>()) {
                        HStack {
                            EntityTypeSelectorImageView(imageName: Droid.exampleImageName)
                            Text(Droid.displayName)
                        }
                    }

                    // Varias
                    NavigationLink(destination: EntitiesListView<Varia>()) {
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
    ChooseEntityTypeView()
}
