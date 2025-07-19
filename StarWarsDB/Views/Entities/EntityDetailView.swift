import SwiftUI

struct EntityDetailView<T: Entity>: View {
    var entity: T
    
    var body: some View {
        // Use type checking instead of entityType switch
        if let character = entity as? Character {
            CharacterDetailView(character: character)
        } else if let creature = entity as? Creature {
            CreatureDetailView(creature: creature)
        } else if let droid = entity as? Droid {
            DroidDetailView(droid: droid)
        } else if let organization = entity as? Organization {
            OrganizationDetailView(organization: organization)
        } else if let planet = entity as? Planet {
            PlanetDetailView(planet: planet)
        } else if let species = entity as? Species {
            SpeciesDetailView(species: species)
        } else if let starshipModel = entity as? StarshipModel {
            StarshipModelDetailView(starshipModel: starshipModel)
        } else if let starship = entity as? Starship {
            StarshipDetailView(starship: starship)
        } else if let varia = entity as? Varia {
            VariaDetailView(varia: varia)
        } else {
            // Fallback for unsupported types
            Text("Unsupported entity type: \(type(of: entity))")
        }
    }
}

#Preview {
    EntityDetailView<Character>(entity: Character.example)
}
