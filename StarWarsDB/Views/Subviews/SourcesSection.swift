import SwiftUI

/// A section that displays a list of sources by era.
struct SourcesSection: View {
    var sourceEntities: [SourceEntity]
    
    private var firstCanon: SourceEntity? {
        sourceEntities.min(by: { $0.source.publicationDate < $1.source.publicationDate })
    }
    
    private var groupedEras: [Era: [SourceEntity]] {
        Dictionary(grouping: sourceEntities, by: { $0.source.era })
    }
    
    var body: some View {
        List {
            ForEach(Era.allCases, id: \.self) { era in
                if let entities = groupedEras[era] {
                    SourcesByEraView(era: era, entities: entities, firstCanon: firstCanon)
                }
            }
        }
    }
}

/// A view that displays a list of sources by era.
struct SourcesByEraView: View {
    let era: Era
    let entities: [SourceEntity]
    let firstCanon: SourceEntity?
    
    var sortedEntities: [SourceEntity] {
        entities.sorted { $0.source.publicationDate < $1.source.publicationDate }
    }
    
    var body: some View {
        Section(header: Text(era.rawValue)) {
            ForEach(sortedEntities) { sourceEntity in
                NavigationLink(destination: EditSourceView(source: sourceEntity.source)) {
                    SourceRow(
                        sourceEntity: sourceEntity,
                        oldest: sourceEntity.id == firstCanon?.id
                    )
                }
            }
        }
    }
}

/// A view that displays the name and series information of a source        
struct SourceNameView: View {
    let name: String
    let serie: Serie?
    let number: Int?
    let oldest: Bool
    
    var body: some View {
        if name == "" {
            HStack (spacing: 4) {
                Text(serie?.name ?? "")
                Text(number?.description ?? "")
            }
            .font(.headline)
            .foregroundColor(oldest ? Color.red : Color.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
        } else if serie == nil {
            Text(name)
                .font(.headline)
                .foregroundColor(oldest ? Color.red : Color.primary)
                .lineLimit(1) // Ensures text doesn't overflow
                .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            VStack (alignment: .leading, spacing: 4) {
                
                Text(name)
                    .font(.headline)
                    .foregroundColor(oldest ? Color.red : Color.primary)
                    .lineLimit(1) // Ensures text doesn't overflow
                HStack (spacing: 4) {
                    Text(serie?.name ?? "")
                    Text(number?.description ?? "")
                }
                .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct SourceRow: View {
    let sourceEntity: SourceEntity
    let oldest: Bool
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private var formattedDate: String {
        Self.dateFormatter.string(from: sourceEntity.source.publicationDate)
    }
    
    var body: some View {
        HStack(spacing: 20) {
            UniverseYear(year: sourceEntity.source.universeYear)
                .frame(width: 50, alignment: .leading)
            
            Image(sourceEntity.source.id.uuidString.lowercased())
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
            
            SourceNameView(
                name: sourceEntity.source.name,
                serie: sourceEntity.source.serie,
                number: sourceEntity.source.number,
                oldest: oldest
                )
                       
            Text(formattedDate)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .frame(width: 100, alignment: .center)

            AppearanceView(appearance: sourceEntity.appearance.rawValue)
                .frame(width: 80, alignment: .center)
        }
    }
}

struct UniverseYear: View {
    let year: Float?
    
    var body: some View {
        VStack {
            if let year {
                Text("\(abs(Int(year)))")
                Text(year > 0 ? "ABY" : "BBY")
            } else {
                Text("")
            }
        }
        .font(.caption)
        .foregroundColor(.secondary)
    }
}

#Preview {
    SourcesSection(sourceEntities: SourceCharacter.example)
}
