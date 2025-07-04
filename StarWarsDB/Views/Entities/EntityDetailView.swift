import SwiftUI

struct EntityDetailView: View {
    @State var entityType: EntityType
    var entity: Entity
    
    var body: some View {
        switch entityType {
        case .character: CharacterDetailView(character: entity as! Character)
        case .creature: CreatureDetailView(creature: entity as! Creature)
        case .droid: DroidDetailView(droid: entity as! Droid)
        case .organization: OrganizationDetailView(organization: entity as! Organization)
        case .planet: PlanetDetailView(planet: entity as! Planet)
        case .species: SpeciesDetailView(species: entity as! Species)
        case .starshipModel: StarshipModelDetailView(starshipModel: entity as! StarshipModel)
        case .starship: StarshipDetailView(starship: entity as! Starship)
        case .varia: VariaDetailView(varia: entity as! Varia)
        case .arc: ArcDetailView(arc: entity as! Arc)
        case .serie: SerieDetailView(serie: entity as! Serie)
        case .artist: ArtistDetailView(artist: entity as! Artist)
        case .author: ArtistDetailView(artist: entity as! Artist)
        }
    }
}

#Preview {
    EntityDetailView(entityType: .character, entity: Character.example)
}
