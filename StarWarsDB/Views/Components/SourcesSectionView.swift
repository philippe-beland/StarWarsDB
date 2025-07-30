import SwiftUI

// Global date formatter to avoid static properties in generics
private let sourceDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()

/// A section that displays a list of sources by era for a specific entity type.
struct SourcesSectionView<T: TrackableEntity>: View {
    var sourceEntities: [SourceEntity<T>]
    
    private var firstCanon: SourceEntity<T>? {
        sourceEntities.min(by: { $0.source.publicationDate < $1.source.publicationDate })
    }
    
    private var groupedEras: [Era: [SourceEntity<T>]] {
        Dictionary(grouping: sourceEntities, by: { $0.source.era })
    }
    
    var body: some View {
        List {
            ForEach(Era.allCases, id: \ .self) { era in
                if let entities = groupedEras[era] {
                    SourcesByEraView<T>(era: era, entities: entities, firstCanon: firstCanon)
                }
            }
        }
    }
}

/// A view that displays a list of sources by era for a specific entity type.
struct SourcesByEraView<T: TrackableEntity>: View {
    let era: Era
    let entities: [SourceEntity<T>]
    let firstCanon: SourceEntity<T>?
    
    var sortedEntities: [SourceEntity<T>] {
        entities.sorted { $0.source.publicationDate < $1.source.publicationDate }
    }
    
    var body: some View {
        Section(header: Text(era.rawValue)) {
            ForEach(sortedEntities, id: \ .id) { sourceEntity in
                SourceRowNavigation(sourceEntity: sourceEntity, isOldest: sourceEntity.id == firstCanon?.id)
            }
        }
    }
}

struct SourceRowNavigation<T: TrackableEntity>: View {
    let sourceEntity: SourceEntity<T>
    let isOldest: Bool

    @State private var viewModel: EditSourceViewModel

    init(sourceEntity: SourceEntity<T>, isOldest: Bool) {
        self.sourceEntity = sourceEntity
        self.isOldest = isOldest
        _viewModel = State(initialValue: EditSourceViewModel(source: sourceEntity.source))
    }

    var body: some View {
        NavigationLink(destination: SourceDetailView(viewModel: viewModel)) {
            SourceRow(sourceEntity: sourceEntity, oldest: isOldest)
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
        VStack(alignment: .leading, spacing: Constants.Spacing.xs) {
            if !name.isEmpty {
                Text(name)
                    .lineLimit(1)
            }
            
            if let serie = serie {
                HStack (spacing: Constants.Spacing.xs) {
                    Text(serie.name)
                    if let number = number {
                        Text(String(number))
                    }
                }
                .foregroundColor(name.isEmpty ? (oldest ? .red : .primary) : .secondary)
            }
        }
        .font(.headline)
        .foregroundColor(oldest && serie == nil ? .red : .primary)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SourceRow<T: TrackableEntity>: View {
    let sourceEntity: SourceEntity<T>
    let oldest: Bool
    
    private var formattedDate: String {
        sourceDateFormatter.string(from: sourceEntity.source.publicationDate)
    }
    
    var body: some View {
        HStack(spacing: Constants.Spacing.xl) {
            UniverseYear(year: sourceEntity.source.universeYear)
                .frame(width: Constants.Layout.yearViewWidth, alignment: .leading)
            
            CDNImageView(primaryID: sourceEntity.source.id)
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
                .frame(width: Constants.Layout.dateViewWidth, alignment: .center)
            
            AppearanceView(appearance: sourceEntity.appearance)
                .frame(width: Constants.Layout.appearanceViewWidth, alignment: .center)
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

//#Preview {
//    var sourceCharacters = SourceEntity<Character>(source: .example, entity: .example, appearance: .present)
//    var examples = sourceCharacters.examples
//    SourcesSectionView<Character>(sourceEntities: examples)
//}
