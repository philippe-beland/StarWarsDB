import SwiftUI

struct AddEntitySheet: View {
    var entityType: EntityType
    var onAdd: (Entity) -> Void
    
    var body: some View {
        switch entityType {
        case .character: AddCharacterView(name: "", onCharacterCreation: onAdd)
        case .creature: AddCreatureView(name: "", onCreatureCreation: onAdd)
        case .droid: AddDroidView(name: "", onDroidCreation: onAdd)
        case .organization: AddOrganizationView(name: "", onOrganizationCreation: onAdd)
        case .planet: AddPlanetView(name: "", onPlanetCreation: onAdd)
        case .species: AddSpeciesView(name: "", onSpeciesCreation: onAdd)
        case .starshipModel: AddStarshipModelView(name: "", onStarshipModelCreation: onAdd)
        case .starship: AddStarshipView(name: "", onStarshipCreation: onAdd)
        case .varia: AddVariaView(name: "", onVariaCreation: onAdd)
        case .arc: AddArcView(name: "", onArcCreation: onAdd)
        case .serie: AddSerieView(name: "", onSerieCreation: onAdd)
        case .artist: AddArtistView(name: "", onArtistCreation: onAdd)
        case .author: AddArtistView(name: "", onArtistCreation: onAdd)
        }
    }
}

#Preview {
    AddEntitySheet(entityType: .creature, onAdd: { _ in })
}
