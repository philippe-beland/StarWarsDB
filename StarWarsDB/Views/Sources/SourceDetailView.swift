import SwiftUI

// MARK: - ActiveSheet

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

// MARK: - Main View
struct SourceDetailView: View {
    @Bindable var viewModel: EditSourceViewModel
    @State private var showFactSheet: Bool = false
    
    // MARK: - View Body
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: Constants.Spacing.md) {
                SourceHeaderView(source: $viewModel.source, showFactSheet: $showFactSheet)
                    .padding(.horizontal, Constants.Spacing.lg)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Constants.Spacing.md) {
                        // Serie
                        InfoBlock(title: "Serie") {
                            EditableLinkedBaseEntity(
                                baseEntity: Binding(
                                    get: { viewModel.source.serie ?? Serie.empty },
                                    set: { viewModel.source.serie = $0 }
                                )
                            ) {
                                if let serieName = viewModel.source.serie?.name {
                                    Text ("(\(serieName))")
                                        .foregroundColor(.blue)
                                } else {
                                    Text("Select Serie")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        
                        //Arc
                        InfoBlock(title: "Arc") {
                            EditableLinkedBaseEntity(
                                baseEntity: Binding(
                                    get: { viewModel.source.arc ?? Arc.empty },
                                    set: { viewModel.source.arc = $0 }
                                )
                            ){
                                if let arcName = viewModel.source.arc?.name {
                                    Text ("(\(arcName))")
                                        .foregroundColor(.blue)
                                } else {
                                    Text("Select Arc")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        
                        // Number
                        InfoBlock(title: "Number") {
                            TextField("Number", value: $viewModel.source.number, format: .number)
                        }
                        
                        // Era
                        InfoBlock(title: "Era") {
                            EraPicker(era: $viewModel.source.era)
                        }
                        
                        // Type
                        InfoBlock(title: "Type") {
                            SourceTypePicker(sourceType: $viewModel.source.sourceType)
                        }
                        
                        // Publication Date
                        InfoBlock(title: "Publication Date") {
                            PublicationDatePicker(date: $viewModel.source.publicationDate)
                        }
                        
                        // In-Universe Year
                        InfoBlock(title: "In-Universe Year") {
                            YearPicker(era: viewModel.source.era, universeYear: $viewModel.source.universeYear)
                        }
                        
                        // Authors
                        InfoBlock(title: "Authors") {
                            AuthorsVStack(source: viewModel.source, sourceAuthors: $viewModel.authors)
                        }
                        
                        // Authors
                        InfoBlock(title: "Artists") {
                            ArtistsVStack(source: viewModel.source, sourceArtists: $viewModel.artists)
                        }
                        
                        // Number of Pages
                        InfoBlock(title: "Number of pages") {
                            TextField("Nb of pages", value: $viewModel.source.numberPages, format: .number)
                        }
                    }
                }
                
                SourceAppearancesSection(
                    viewModel: viewModel,
                    serie: viewModel.source.serie,
                    url: viewModel.source.url,
                    onAddEntity: viewModel.addAnyEntity
                )
                .padding(.top, Constants.Spacing.md)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .task { await viewModel.loadInitialSources() }
        .toolbar {
            Button("Update") {
                Task {
                    await viewModel.source.update()
                }
            }
        }
    }
}

private struct InfoBlock<Content: View>: View {
    let title: String
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            content()
                .frame(minWidth: Constants.Layout.minInfoWidth)
        }
        .padding(Constants.Spacing.sm)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(Constants.CornerRadius.md)
    }
}

//// MARK: - Preview
//#Preview {
//    SourceDetailView(source: .example)
//}
