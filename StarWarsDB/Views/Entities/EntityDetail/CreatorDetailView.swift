import SwiftUI

struct CreatorDetailView<T: CreatorEntity>: View {
    var creator: T
    
    @State private var sourceCreators: [SourceCreator<T>] = []
    
    private var groupedByEra: [Era: [SourceCreator<T>]] {
        Dictionary(grouping: sourceCreators, by: { $0.source.era })
    }
    
    var body: some View {
        List {
            ForEach(Era.allCases, id: \.self) { era in
                if let creators = groupedByEra[era] {
                    Section(era.rawValue) {
                        ForEach(creators) { sourceCreator in
                            NavigationLink(destination: SourceDetailView(viewModel: EditSourceViewModel(source: sourceCreator.source))) {
                                CreatorSourceRow(source: sourceCreator.source)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(creator.name)
        .overlay {
            if sourceCreators.isEmpty {
                ContentUnavailableView("No sources", systemImage: "doc.text", description: Text("This \(T.displayName.lowercased().dropLast()) hasn't been assigned to any sources yet."))
            }
        }
        .task { await loadSources() }
    }
    
    private func loadSources() async {
        if let _ = creator as? Artist {
            sourceCreators = await loadArtistSources(artistID: creator.id) as! [SourceCreator<T>]
        } else if let _ = creator as? Author {
            sourceCreators = await loadAuthorSources(authorID: creator.id) as! [SourceCreator<T>]
        }
    }
}

private struct CreatorSourceRow: View {
    let source: Source
    
    var body: some View {
        HStack(spacing: Constants.Spacing.sm) {
            CDNImageView(primaryID: source.id)
                .frame(width: 36, height: 36)
                .clipShape(.rect(cornerRadius: 6))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(source.name ?? "Untitled")
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(2)
                
                if let serie = source.serie {
                    HStack(spacing: Constants.Spacing.xs) {
                        Text(serie.name)
                        if let number = source.number {
                            Text("#\(number)")
                        }
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Text(source.era.rawValue)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    NavigationStack {
        CreatorDetailView<Artist>(creator: .example)
    }
}
