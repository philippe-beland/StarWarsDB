//
//  EditEntityView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/17/24.
//

import SwiftUI

struct EditEntityView: View {
    @State var entityType: EntityType
    var entity: Entity
    
    var body: some View {
        switch entityType {
        case .character: EditCharacterView(character: entity as! Character)
        case .creature: EditCreatureView(creature: entity as! Creature)
        case .droid: EditDroidView(droid: entity as! Droid)
        case .organization: EditOrganizationView(organization: entity as! Organization)
        case .planet: EditPlanetView(planet: entity as! Planet)
        case .species: EditSpeciesView(species: entity as! Species)
        case .starshipModel: EditStarshipModelView(starshipModel: entity as! StarshipModel)
        case .starship: EditStarshipView(starship: entity as! Starship)
        case .varia: EditVariaView(varia: entity as! Varia)
        case .arc: EditArcView(arc: entity as! Arc)
        case .serie: EditSerieView(serie: entity as! Serie)
        }
    }
}

#Preview {
    EditEntityView(entityType: .character, entity: Character.example)
}
