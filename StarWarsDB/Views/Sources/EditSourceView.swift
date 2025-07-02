import SwiftUI

struct SourceItemCollection {
    var characters: [SourceCharacter] = []
    var creatures: [SourceCreature] = []
    var droids: [SourceDroid] = []
    var organizations: [SourceOrganization] = []
    var planets: [SourcePlanet] = []
    var species: [SourceSpecies] = []
    var starships: [SourceStarship] = []
    var starshipModels: [SourceStarshipModel] = []
    var varias: [SourceVaria] = []
    var artists: [SourceArtist] = []
    var authors: [SourceAuthor] = []
}

enum ActiveSheet: Identifiable {
    case entitySheet(EntityType)
    case referenceSheet(EntityType)
    case expandedSheet(EntityType)
    
    var id: String {
        switch self {
        case .entitySheet(let type):
            return "entity-\(type)"
        case .referenceSheet(let type):
            return "reference-\(type)"
        case .expandedSheet(let type):
            return "expanded-\(type)"
        }
    }
}

struct EditSourceView: View {
    @StateObject private var viewModel: EditSourceViewModel
    @State private var showFactSheet: Bool = false
    
    init(source: Source) {
        _viewModel = StateObject(wrappedValue: EditSourceViewModel(source: source))
    }
    
    private var sortedArtists: [SourceArtist] {
        viewModel.sourceItems.artists.sorted (by: { $0.entity.name < $1.entity.name })
    }
    
    private var sortedAuthors: [SourceAuthor] {
        viewModel.sourceItems.authors.sorted(by: { $0.entity.name < $1.entity.name })
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                SourceHeaderSection(source: $viewModel.source, showFactSheet: $showFactSheet)
                    .padding(.horizontal, 20)
                SourceInfoSection(infosSection: infosSection)
                SourcesAppearancesSection(
                    sourceItems: $viewModel.sourceItems,
                    activeSheet: $viewModel.activeSheet,
                    serie: viewModel.source.serie,
                    url: viewModel.source.url,
                    onAddEntity: viewModel.addSourceItem
                )
                .padding(.top, 16)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .task { await viewModel.loadInitialSources() }
        .toolbar {
            Button("Update", action: viewModel.source.update)
        }
    }
    
    private var infosSection: [InfoSection] {
        let sections: [InfoSection] = [
            InfoSection(fieldName: "Serie", view: AnyView(EditVEntityInfoView(
                fieldName: "Serie",
                entity: Binding(
                    get: {viewModel.source.serie ?? Serie.empty },
                    set: {viewModel.source.serie = ($0 as! Serie) }),
                entityType: .serie))),
            InfoSection(fieldName: "Arc", view: AnyView(EditVEntityInfoView(
                fieldName: "Arc",
                entity: Binding(
                    get: {viewModel.source.arc ?? Arc.empty },
                    set: {viewModel.source.arc = ($0 as! Arc) }),
                entityType: .arc))),
            InfoSection(fieldName: "Number", view: AnyView(TextField("Number", value: $viewModel.source.number, format: .number))),
            InfoSection(fieldName: "Era", view: AnyView(EraPicker(era: $viewModel.source.era))),
            InfoSection(fieldName: "Type", view: AnyView(SourceTypePicker(sourceType: $viewModel.source.sourceType))),
            InfoSection(fieldName: "Publication Date", view: AnyView(PublicationDatePicker(date: $viewModel.source.publicationDate))),
            InfoSection(fieldName: "In-Universe Year", view: AnyView(YearPicker(era: viewModel.source.era, universeYear: $viewModel.source.universeYear))),
            InfoSection(fieldName: "Authors", view: AnyView(AuthorsVStack(source: viewModel.source, authors: sortedAuthors))),
            InfoSection(fieldName: "Artists", view: AnyView(ArtistsVStack(source: viewModel.source, artists: sortedArtists))),
            InfoSection(fieldName: "Number Pages", view: AnyView(TextField("Nb of pages", value: $viewModel.source.numberPages, format: .number))),
            InfoSection(fieldName: "URL", view: AnyView(TextField("URL", text: $viewModel.source.wookieepediaTitle)))
        ]
        
        return sections
    }
}

private struct SourceInfoSection: View {
    let infosSection: [InfoSection]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(infosSection) { info in
                    VStack(alignment: .leading) {
                        Text(info.fieldName)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        info.view
                            .frame(minWidth: 120)
                    }
                    .padding(12)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                }
            }
        }
        .padding([.horizontal])
    }
}
        
private struct InfoSection: Identifiable {
    let id: UUID = UUID()
    let fieldName: String
    let view: AnyView
}
