import SwiftUI

struct EntityBrowserView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // Replace the ForEach with explicit NavigationLinks
                    NavigationLink(destination: EntitiesListView<Character>()) {
                        HStack {
                            Image(Character.exampleImageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            Text(Character.displayName)
                        }
                    }
                    
                    NavigationLink(destination: EntitiesListView<Species>()) {
                        HStack {
                            Image(Species.exampleImageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            Text(Species.displayName)
                        }
                    }
                    
                    NavigationLink(destination: EntitiesListView<Planet>()) {
                        HStack {
                            Image(Planet.exampleImageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            Text(Planet.displayName)
                        }
                    }
                    
                    NavigationLink(destination: EntitiesListView<Organization>()) {
                        HStack {
                            Image(Organization.exampleImageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            Text(Organization.displayName)
                        }
                    }
                    
                    NavigationLink(destination: EntitiesListView<Starship>()) {
                        HStack {
                            Image(Starship.exampleImageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            Text(Starship.displayName)
                        }
                    }
                    
                    NavigationLink(destination: EntitiesListView<StarshipModel>()) {
                        HStack {
                            Image(StarshipModel.exampleImageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            Text(StarshipModel.displayName)
                        }
                    }
                    
                    NavigationLink(destination: EntitiesListView<Creature>()) {
                        HStack {
                            Image(Creature.exampleImageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            Text(Creature.displayName)
                        }
                    }

                    NavigationLink(destination: EntitiesListView<Droid>()) {
                        HStack {
                            Image(Droid.exampleImageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            Text(Droid.displayName)
                        }
                    }

                    NavigationLink(destination: EntitiesListView<Varia>()) {
                        HStack {
                            Image(Varia.exampleImageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
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
