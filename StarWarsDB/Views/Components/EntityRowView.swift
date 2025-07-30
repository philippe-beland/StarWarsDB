import SwiftUI

struct EntityRowView<T: BaseEntity>: View {
    let entity: T
    
    var body: some View {
        HStack {
            CDNImageView(primaryID: entity.id)
                .frame(width: 50, height: 50, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: Constants.CornerRadius.sm))
                .shadow(radius: 5)
            
            VStack(alignment: .leading) {
                    Text(entity.name)
                        .foregroundColor(entity.alreadyInSource ? .gray : .primary)
                        .bold()

                if let subtitle = subtitle(entity: entity) {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            if let detail = detail(entity: entity) {
                Text(detail)
                    .foregroundColor(entity.alreadyInSource ? .gray : .primary)
                    .font(.callout)
            }
        }
    }
    
    private func subtitle(entity: T) -> String? {
        if let character = entity as? Character {
            return character.alias
        } else if let planet = entity as? Planet {
            return planet.region.rawValue
        } else {
            return nil
        }
    }
    
    private func detail(entity: T) -> String? {
        if let character = entity as? Character {
            return "\(character.species?.name ?? ""), \(character.gender)"
        } else if let planet = entity as? Planet {
            return planet.capitalCity
        } else if let species = entity as? Species {
            return species.homeworld?.name
        } else if let starship = entity as? Starship {
            return starship.model?.name
        } else if let creature = entity as? Creature {
            return creature.homeworld?.name
        } else {
            return nil
        }
    }
}

#Preview {
    EntityRowView<Organization>(entity: .example)
}
