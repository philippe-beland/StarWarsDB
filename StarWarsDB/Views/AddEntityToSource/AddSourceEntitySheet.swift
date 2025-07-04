import SwiftUI

struct AddSourceEntitySheet: View {
    var entityType: EntityType
    var onAdd: (Entity) -> Void
    
    var body: some View {
        switch entityType {
        case .character: AddCharacterView(onCharacterCreation: onAdd)
        case .creature: AddCreatureView(onCreatureCreation: onAdd)
        case .droid: AddDroidView(onDroidCreation: onAdd)
        case .organization: AddOrganizationView(onOrganizationCreation: onAdd)
        case .planet: AddPlanetView(onPlanetCreation: onAdd)
        case .species: AddSpeciesView(onSpeciesCreation: onAdd)
        case .starshipModel: AddStarshipModelView(onStarshipModelCreation: onAdd)
        case .starship: AddStarshipView(onStarshipCreation: onAdd)
        case .varia: AddVariaView(onVariaCreation: onAdd)
        case .arc: AddArcView(onArcCreation: onAdd)
        case .serie: AddSerieView(onSerieCreation: onAdd)
        case .artist: AddArtistView(onArtistCreation: onAdd)
        case .author: AddArtistView(onArtistCreation: onAdd)
        }
    }
}

#Preview {
    AddSourceEntitySheet(entityType: .creature, onAdd: { _ in })
}
