//
//  EntityRow.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/17/24.
//

import SwiftUI

struct EntityRowView: View {
    let entityType: EntityType
    let entity: any Record
    
    var body: some View {
        switch entityType {
            case .character: CharacterRowView(character: entity as! Character)
            case .creature: CreatureRowView(creature: entity as! Creature)
            case .droid: DroidRowView(droid: entity as! Droid)
            case .organization: OrganizationRowView(organization: entity as! Organization)
            case .planet: PlanetRowView(planet: entity as! Planet)
            case .species: SpeciesRowView(species: entity as! Species)
            case .starshipModel: StarshipModelRowView(starshipModel: entity as! StarshipModel)
            case .starship: StarshipRowView(starship: entity as! Starship)
        }
    }
    
}

struct CharacterRowView: View {
    let character: Character
    
    var body: some View {
        HStack {
            Image("Luke_Skywalker")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack (alignment: .leading) {
                Text(character.name)
                Text(character.alias)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Text(character.species?.name ?? "")
                .font(.callout)
            Spacer()
            Text(character.affiliation)
                .font(.callout)
        }
    }
}

struct CreatureRowView: View {
    let creature: Creature
    
    var body: some View {
        HStack {
            Image("Luke_Skywalker")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            Text(creature.name)
            Text(creature.homeworld?.name ?? "")
                .font(.callout)
        }
    }
}

struct DroidRowView: View {
    let droid: Droid
    
    var body: some View {
        HStack {
            Image("Luke_Skywalker")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())

            Text(droid.name)
        }
    }
}

struct OrganizationRowView: View {
    let organization: Organization
    
    var body: some View {
        HStack {
            Image("Luke_Skywalker")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            Text(organization.name)
        }
    }
}

struct PlanetRowView: View {
    let planet: Planet
    
    var body: some View {
        HStack {
            Image("Luke_Skywalker")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack (alignment: .leading) {
                Text(planet.name)
                Text(planet.region?.rawValue ?? "")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(planet.capitalCity ?? "")
                .font(.callout)
        }
    }
}

struct SpeciesRowView: View {
    let species: Species
    
    var body: some View {
        HStack {
            Image("Luke_Skywalker")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            Text(species.name)
            Text(species.homeworld?.name ?? "")
                .font(.callout)
        }
    }
}

struct StarshipModelRowView: View {
    let starshipModel: StarshipModel
    
    var body: some View {
        HStack {
            Image("Luke_Skywalker")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            Text(starshipModel.name)
        }
    }
}

struct StarshipRowView: View {
    let starship: Starship
    
    var body: some View {
        HStack {
            Image("Luke_Skywalker")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            Text(starship.name)
            Text(starship.model?.name ?? "")
                .font(.callout)
        }
    }
}

#Preview {
    EntityRowView(entityType: .organization, entity: Organization.example)
}
