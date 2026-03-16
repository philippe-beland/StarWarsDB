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
        VStack(alignment: .leading, spacing: 2) {
            if !name.isEmpty {
                Text(name)
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(2)
            }

            if let serie {
                HStack(spacing: Constants.Spacing.xs) {
                    Text(serie.name)
                    if let number {
                        Text("#\(number)")
                    }
                }
                .font(.caption)
                .foregroundStyle(name.isEmpty ? (oldest ? .red : .primary) : .secondary)
            }
        }
        .foregroundStyle(oldest && serie == nil ? .red : .primary)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SourceRow<T: TrackableEntity>: View {
    let sourceEntity: SourceEntity<T>
    let oldest: Bool
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private var isCompact: Bool { horizontalSizeClass == .compact }

    private var formattedDate: String {
        sourceDateFormatter.string(from: sourceEntity.source.publicationDate)
    }

    private var yearText: String {
        let year = sourceEntity.source.universeYear
        return "\(abs(Int(year))) \(year > 0 ? "ABY" : "BBY")"
    }

    private var appearanceColor: Color { sourceEntity.appearance.color }

    var body: some View {
        HStack(spacing: isCompact ? Constants.Spacing.sm : Constants.Spacing.lg) {
            CDNImageView(primaryID: sourceEntity.source.id)
                .frame(width: 36, height: 36)
                .clipShape(.rect(cornerRadius: 6))
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .strokeBorder(appearanceColor.opacity(0.5), lineWidth: 1.5)
                )

            if isCompact {
                compactContent
            } else {
                regularContent
            }
        }
    }

    private var compactContent: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                SourceNameView(
                    name: sourceEntity.source.name,
                    serie: sourceEntity.source.serie,
                    number: sourceEntity.source.number,
                    oldest: oldest
                )

                HStack(spacing: Constants.Spacing.xs) {
                    Text(yearText)
                    Text("·")
                    Text(formattedDate)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Spacer()

            AppearanceView(appearance: sourceEntity.appearance)
        }
    }

    private var regularContent: some View {
        HStack(spacing: Constants.Spacing.lg) {
            UniverseYear(year: sourceEntity.source.universeYear)
                .frame(width: Constants.Layout.yearViewWidth, alignment: .leading)

            SourceNameView(
                name: sourceEntity.source.name,
                serie: sourceEntity.source.serie,
                number: sourceEntity.source.number,
                oldest: oldest
            )

            Text(formattedDate)
                .font(.caption)
                .foregroundStyle(.secondary)
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

#Preview {
    let sourceCharacters = SourceEntity<Character>(source: .example, entity: .example, appearance: .present)
    let examples = [sourceCharacters, sourceCharacters]
    SourcesSectionView<Character>(sourceEntities: examples)
}
