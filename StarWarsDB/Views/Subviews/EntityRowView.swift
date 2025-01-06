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
            case .varia: VariaRowView(varia: entity as! Varia)
            case .arc: ArcRowView(arc: entity as! Arc)
            case .serie: SerieRowView(serie: entity as! Serie)
        }
    }
    
}

func imageOrPlaceholder(for id: UUID) -> Image {
    if let uiImage = UIImage(named: id.uuidString.lowercased()) {
        return Image(uiImage: uiImage)
    } else {
        return Image(systemName: "person.crop.circle.fill")
    }
}

struct CharacterRowView: View {
    let character: Character
    
    var body: some View {
        HStack {
            imageOrPlaceholder(for: character.id)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .foregroundStyle(.secondary)
            
            if !character.alias.isEmpty {
                Text(character.name)
            } else {
                VStack (alignment: .leading) {
                    Text(character.name)
                    Text(character.alias)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            Text(character.species?.name ?? "")
                .font(.callout)
//            Text(character.affiliation)
//                .font(.callout)
        }
    }
}

struct CreatureRowView: View {
    let creature: Creature
    
    var body: some View {
        HStack {
            imageOrPlaceholder(for: creature.id)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .foregroundStyle(.secondary)
            
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
            imageOrPlaceholder(for: droid.id)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .foregroundStyle(.secondary)

            Text(droid.name)
        }
    }
}

struct OrganizationRowView: View {
    let organization: Organization
    
    var body: some View {
        HStack {
            imageOrPlaceholder(for: organization.id)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .foregroundStyle(.secondary)
            
            Text(organization.name)
        }
    }
}

struct PlanetRowView: View {
    let planet: Planet
    
    var body: some View {
        HStack {
            imageOrPlaceholder(for: planet.id)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .foregroundStyle(.secondary)
            
            VStack (alignment: .leading) {
                Text(planet.name)
                Text(planet.region.rawValue)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(planet.capitalCity)
                .font(.callout)
        }
    }
}

struct SpeciesRowView: View {
    let species: Species
    
    var body: some View {
        HStack {
            imageOrPlaceholder(for: species.id)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .foregroundStyle(.secondary)
            
            Text(species.name)
            Spacer()
            Text(species.homeworld?.name ?? "")
                .font(.callout)
        }
    }
}

struct StarshipModelRowView: View {
    let starshipModel: StarshipModel
    
    var body: some View {
        HStack {
            imageOrPlaceholder(for: starshipModel.id)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .foregroundStyle(.secondary)
            
            Text(starshipModel.name)
        }
    }
}

struct StarshipRowView: View {
    let starship: Starship
    
    var body: some View {
        HStack {
            imageOrPlaceholder(for: starship.id)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .foregroundStyle(.secondary)
            
            Text(starship.name)
            Text(starship.model?.name ?? "")
                .font(.callout)
        }
    }
}

struct VariaRowView: View {
    let varia: Varia
    
    var body: some View {
        HStack {
            imageOrPlaceholder(for: varia.id)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .foregroundStyle(.secondary)
            
            Text(varia.name)
        }
    }
}

struct ArcRowView: View {
    let arc: Arc
    
    var body: some View {
        Text(arc.name)
    }
}

struct SerieRowView: View {
    let serie: Serie
    
    var body: some View {
        Text(serie.name)
    }
}

#Preview {
    EntityRowView(entityType: .organization, entity: Organization.example)
}
