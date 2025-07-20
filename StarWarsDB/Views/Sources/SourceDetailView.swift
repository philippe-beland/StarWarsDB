import SwiftUI

struct SourceEntityCollection {
    var characters: [SourceEntity<Character>] = []
    var creatures: [SourceEntity<Creature>] = []
    var droids: [SourceEntity<Droid>] = []
    var organizations: [SourceEntity<Organization>] = []
    var planets: [SourceEntity<Planet>] = []
    var species: [SourceEntity<Species>] = []
    var starships: [SourceEntity<Starship>] = []
    var starshipModels: [SourceEntity<StarshipModel>] = []
    var varias: [SourceEntity<Varia>] = []
    var artists: [SourceEntity<Artist>] = []
    var authors: [SourceEntity<Author>] = []
}

enum ActiveSheet: Identifiable {
    case add(type: any Entity.Type)
    case referenceSheet(type: any Entity.Type)
    case expandedSheet(type: any Entity.Type)
    
    var id: String {
        switch self {
        case .add(let type):
            return "add-\(type)"
        case .referenceSheet(let type):
            return "reference-\(type)"
        case .expandedSheet(let type):
            return "expanded-\(type)"
        }
    }
}

struct SourceDetailView: View {
    @StateObject private var viewModel: EditSourceViewModel
    @State private var showFactSheet: Bool = false
    
    init(source: Source) {
        _viewModel = StateObject(wrappedValue: EditSourceViewModel(source: source))
    }
    
    private var sortedArtists: [SourceEntity<Artist>] {
        viewModel.sourceEntities.artists.sorted (by: { $0.entity.name < $1.entity.name })
    }
    
    private var sortedAuthors: [SourceEntity<Author>] {
        viewModel.sourceEntities.authors.sorted(by: { $0.entity.name < $1.entity.name })
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                SourceHeaderSection(source: $viewModel.source, showFactSheet: $showFactSheet)
                    .padding(.horizontal, 20)
                SourceInfoSection(infosSection: infosSection)
                SourcesAppearancesSection(
                    sourceEntities: $viewModel.sourceEntities,
                    activeSheet: $viewModel.activeSheet,
                    serie: viewModel.source.serie,
                    url: viewModel.source.url,
                    onAddEntity: viewModel.addAnyEntity
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
//            InfoSection(fieldName: "Serie", view: AnyView(EditVEntityInfoView(
//                fieldName: "Serie",
//                entity: Binding(
//                    get: {viewModel.source.serie ?? Serie.empty },
//                    set: {viewModel.source.serie = ($0 ) }),
//                ))),
//            InfoSection(fieldName: "Arc", view: AnyView(EditVEntityInfoView(
//                fieldName: "Arc",
//                entity: Binding(
//                    get: {viewModel.source.arc ?? Arc.empty },
//                    set: {viewModel.source.arc = ($0 ) }),
//                ))),
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

#Preview {
    SourceDetailView(source: .example)
}
