import SwiftUI

struct EntityRowView: View {
    let entityType: EntityType
    let entity: any NamedEntity
    
    var body: some View {
        HStack {
            imageOrPlaceholder(for: entity.id)
            
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
    
    private func subtitle(for entityType: EntityType, entity: any NamedEntity) -> String? {
        switch entityType {
        case .character:
            return (entity as? Character)?.alias
        case .planet:
            return (entity as? Planet)?.region.rawValue
        default:
            return nil
        }
    }
    
    private func detail(for entityType: EntityType, entity: any NamedEntity) -> String? {
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

func imageOrPlaceholder(for id: UUID, size: CGFloat=50) -> some View {
    let baseURL = "https://pub-84c7e404f0cb414d8809fe98cb5dedff.r2.dev/"
    let url = URL(string: "\(baseURL)\(id.uuidString.lowercased()).jpg")

    return AsyncImage(url: url) { phase in
        switch phase {
        case .empty:
            ProgressView()
                .frame(width: size, height: size)
        case .success(let image):
            image
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
        case .failure:
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundStyle(.secondary)
        @unknown default:
            EmptyView()
        }
    }
}

#Preview {
    EntityRowView(entityType: .organization, entity: Organization.example)
}
