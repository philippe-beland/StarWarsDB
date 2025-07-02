import SwiftUI

struct EntityRowView: View {
    let entityType: EntityType
    let entity: any Record
    
    var body: some View {
        HStack {
            imageOrPlaceholder(for: entity.id)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .foregroundStyle(.secondary)
            
            VStack(alignment: .leading) {
                if let specificEntity = entity as? Entity {
                    Text(specificEntity.name)
                        .foregroundColor(specificEntity.isExisting ? .gray : .primary)
                        .bold()
                } else {
                    Text(entity.name)
                        .bold()
                }
                if let subtitle = subtitle(for: entityType, entity: entity) {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            if let detail = detail(for: entityType, entity: entity) {
                if let specificEntity = entity as? Entity {
                    Text(detail)
                        .foregroundColor(specificEntity.isExisting ? .gray : .primary)
                        .font(.callout)
                } else {
                    Text(detail)
                        .font(.callout)
                }
            }
        }
    }
    
    private func subtitle(for entityType: EntityType, entity: any Record) -> String? {
        switch entityType {
        case .character:
            return (entity as? Character)?.alias
        case .planet:
            return (entity as? Planet)?.region.rawValue
        default:
            return nil
        }
    }
    
    private func detail(for entityType: EntityType, entity: any Record) -> String? {
        switch entityType {
        case .character:
            return (entity as? Character).flatMap { "\($0.species?.name ?? ""), \($0.gender)" }
        case .planet:
            return (entity as? Planet)?.capitalCity
        case .species:
            return (entity as? Species)?.homeworld?.name
        case .starship:
            return (entity as? Starship)?.model?.name
        case .creature:
            return (entity as? Creature)?.homeworld?.name
        default:
            return nil
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

#Preview {
    EntityRowView(entityType: .organization, entity: Organization.example)
}
