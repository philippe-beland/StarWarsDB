import SwiftUI

struct EntityRowView<T: Entity>: View {
    let entity: T
    
    var body: some View {
        HStack {
            imageOrPlaceholder(for: entity.id)
            
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
            return (entity as? Character)?.alias
        } else if let planet = entity as? Planet {
            return (entity as? Planet)?.region.rawValue
        } else {
            return nil
        }
    }
    
    private func detail(entity: T) -> String? {
        if let character = entity as? Character {
            return (entity as? Character).flatMap { "\($0.species?.name ?? ""), \($0.gender)" }
        } else if let planet = entity as? Planet {
            return (entity as? Planet)?.capitalCity
        } else if let species = entity as? Species {
            return (entity as? Species)?.homeworld?.name
        } else if let starship = entity as? Starship {
            return (entity as? Starship)?.model?.name
        } else if let creature = entity as? Creature {
            return (entity as? Creature)?.homeworld?.name
        } else {
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
    EntityRowView<Organization>(entity: .example)
}
