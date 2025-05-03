//
//  EditSourceView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

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
            InfoSection(fieldName: "Number Pages", view: AnyView(TextField("Nb of pages", value: $viewModel.source.numberPages, format: .number)))
        ]
        
        return sections
    }
}
    
private struct SourceHeaderSection: View {
    @Binding var source: Source
    @Binding var showFactSheet: Bool
    
    var body: some View {
        HStack {
            Spacer()
            HeaderView(name: $source.name, url: source.url)
            Spacer()
        }
        
        HStack {
            Button("Facts") {
                showFactSheet.toggle()
            }
            .sheet(isPresented: $showFactSheet) {
                FactsView(source: source)
            }
            Spacer()
            Toggle("Done", isOn: $source.isDone)
                .font(.callout)
                .frame(maxWidth: 110)
        }
        .padding([.horizontal])
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
    
struct SourcesAppearancesSection: View {
    @Binding var sourceItems: SourceItemCollection
    @Binding var activeSheet: ActiveSheet?
    var serie: Serie?
    var url: URL?
    let onAddEntity: (EntityType, Entity, AppearanceType) -> Void
    @State private var refreshID = UUID()
    
    var body: some View {
        VStack {
            Text("Appearances")
                .bold()
            Form {
                ForEach(EntityType.sourceTypes, id: \.self) { entityType in
                    Section(header: EntitySectionHeader(
                        title: entityType.displayName,
                        entityType: entityType,
                        activeSheet: $activeSheet,
                        sourceItems: getSourceItemsBinding(for: entityType)
                    )) {
                        ScrollAppearancesView(
                            sourceItems: getSourceItemsBinding(for: entityType),
                            entityType: entityType
                        )
                        .id(refreshID)
                    }
                }
            }
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .entitySheet(let type):
                ChooseEntityView(entityType: type, isSourceItem: true, serie: serie, sourceItems: getSourceItems(for: type)) { selectedEntities, appearance in
                    for selectedEntity in selectedEntities {
                        onAddEntity(type, selectedEntity, appearance)
                        if type == .character && appearance != .mentioned {
                            if let character = selectedEntity as? Character {
                                if let species = character.species {
                                    if species.name.lowercased() != "droid" {
                                        onAddEntity(.species, species, appearance)
                                    }
                                }
                            }
                        } else if type == .starship && appearance != .mentioned {
                            if let starship = selectedEntity as? Starship {
                                if let model = starship.model {
                                    onAddEntity(.starshipModel, model, appearance)
                                }
                            }
                        }
                    }
                }
                
            case .referenceSheet(let type):
                ReferenceItemView(entityType: type, url: url, sourceItems: getSourceItemsBinding(for: type))
                
            case .expandedSheet(let type):
                ExpandedSourceItemView(sourceItems: getSourceItemsBinding(for: type), entityType: type)
                    .onDisappear {
                        refreshID = UUID()
                    }
            }
        }
    }
    
    private func getSourceItems(for entityType: EntityType) -> [SourceItem] {
        switch entityType {
        case .character:
            return sourceItems.characters as [SourceItem]
        case .droid:
            return sourceItems.droids as [SourceItem]
        case .creature:
            return sourceItems.creatures as [SourceItem]
        case .organization:
            return sourceItems.organizations as [SourceItem]
        case .planet:
            return sourceItems.planets as [SourceItem]
        case .species:
            return sourceItems.species as [SourceItem]
        case .starshipModel:
            return sourceItems.starshipModels as [SourceItem]
        case .starship:
            return sourceItems.starships as [SourceItem]
        case .varia:
            return sourceItems.varias as [SourceItem]
        default:
            return []
        }
    }
    
    private func getSourceItemsBinding(for entityType: EntityType) -> Binding<[SourceItem]> {
        switch entityType {
        case .character:
            return Binding(
                get: { sourceItems.characters as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.characters = newItems.compactMap { $0 as? SourceCharacter }
                    sourceItems = updatedCollection
                }
            )
        case .droid:
            return Binding(
                get: { sourceItems.droids as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.droids = newItems.compactMap { $0 as? SourceDroid }
                    sourceItems = updatedCollection
                }
            )
        case .creature:
            return Binding(
                get: { sourceItems.creatures as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.creatures = newItems.compactMap { $0 as? SourceCreature }
                    sourceItems = updatedCollection
                }
            )
        case .organization:
            return Binding(
                get: { sourceItems.organizations as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.organizations = newItems.compactMap { $0 as? SourceOrganization }
                    sourceItems = updatedCollection
                }
            )
        case .planet:
            return Binding(
                get: { sourceItems.planets as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.planets = newItems.compactMap { $0 as? SourcePlanet }
                    sourceItems = updatedCollection
                }
            )
        case .species:
            return Binding(
                get: { sourceItems.species as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.species = newItems.compactMap { $0 as? SourceSpecies }
                    sourceItems = updatedCollection
                }
            )
        case .starshipModel:
            return Binding(
                get: { sourceItems.starshipModels as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.starshipModels = newItems.compactMap { $0 as? SourceStarshipModel }
                    sourceItems = updatedCollection
                }
            )
        case .starship:
            return Binding(
                get: { sourceItems.starships as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.starships = newItems.compactMap { $0 as? SourceStarship }
                    sourceItems = updatedCollection
                }
            )
        case .varia:
            return Binding(
                get: { sourceItems.varias as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.varias = newItems.compactMap { $0 as? SourceVaria }
                    sourceItems = updatedCollection
                }
            )
        default:
            return .constant([]) // Return an empty, immutable Binding for unsupported cases
        }
    }
}
        
private struct InfoSection: Identifiable {
    let id: UUID = UUID()
    let fieldName: String
    let view: AnyView
}
        
        
        
private struct EntitySectionHeader: View {
    let title: String
    let entityType: EntityType
    @Binding var activeSheet: ActiveSheet?
    let sourceItems: Binding<[SourceItem]>
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
            Spacer()
            Button {
                DispatchQueue.main.async {
                    activeSheet = .entitySheet(entityType)
                }
            } label: {
                Label("Add", systemImage: "plus")
                    .foregroundColor(.blue)
            }
            .buttonStyle(BorderlessButtonStyle())
            Spacer()
            Button {
                DispatchQueue.main.async {
                    activeSheet = .referenceSheet(entityType)
                }
            } label: {
                Text("References")
            }
            Button {
                DispatchQueue.main.async {
                    activeSheet = .expandedSheet(entityType)
                }
            } label: {
                Text("Expand")
            }
        }
    }
}
        
struct ReferenceItemView: View {
    var entityType: EntityType
    var url: URL?
    var sourceItems: Binding<[SourceItem]>
    
    @State var listEntities: [String] = []
    @State var processedEntities: [WikiEntity] = []
    
    private var filteredEntities: [WikiEntity] {
        let excludedNames = Set(sourceItems.wrappedValue.map { $0.entity.name })
        let x = processedEntities.filter {
            !excludedNames.contains($0.name)
        }
        return x.sorted { $0.name < $1.name }
    }
    
    var body: some View {
        NavigationStack {
            if !filteredEntities.isEmpty {
                List {
                    ForEach(filteredEntities) { entity in
                        HStack {
                            Text(entity.name)
                                .textSelection(.enabled)
                            Spacer()
                            Text(entity.modifiers.joined(separator: ", "))
                            Spacer()
                            AppearanceView(appearance: entity.appearance.rawValue)
                                .frame(width: 80, alignment: .center)
                        }
                        .textSelection(.enabled)
                    }
                }
                .navigationTitle("Missing Entries")
            } else {
                Text("All good!")
            }
        }
        .task { await fetch_list() }
    }
    
    private func fetch_list() async {
        do {
            listEntities = try await fetchInfo(for: url, type: entityType)
            processedEntities = processWikiEntities(listEntities)
        }
        catch {
            print("Error fetching list: \(error)")
        }
    }
}

struct ExpandedSourceItemView: View {
    @Binding var sourceItems: [SourceItem]
    var entityType: EntityType
    @State private var refreshID = UUID()
    
    private var sortedEntities: [SourceItem] {
        sourceItems.sorted(by: { $0.entity.name < $1.entity.name })
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedEntities) { sourceItem in
                    RecordEntryView(sourceItem: sourceItem)
                        .id(refreshID)
                        .contextMenu {
                            appearanceContextMenu(for: sourceItem)
                        }
                }
                .onDelete(perform: deleteEntity)
            }
            .navigationTitle(entityType.rawValue)
        }
    }
    
    private func appearanceContextMenu(for sourceItem: SourceItem) -> some View {
        Group {
            ForEach(AppearanceType.allCases, id: \.self) { appearance in
                Button(appearance.description) {
                    updateAppearance(of: sourceItem, to: appearance)
                }
            }
        }
    }
    
    private func updateAppearance(of sourceItem: SourceItem, to appearance: AppearanceType) {
        if let index = sourceItems.firstIndex(where: { $0.id == sourceItem.id }) {
            sourceItems[index].appearance = appearance
            sourceItem.update()
            refreshID = UUID()
        }
    }
    
    private func deleteEntity(_ indexSet: IndexSet) {
        for index: IndexSet.Element in indexSet {
            let entity = sortedEntities[index]
            if let indexofSource = sourceItems.firstIndex(of: entity) {
                sourceItems.remove(at: indexofSource)
            }
            entity.delete()
        }
    }
}

extension Entity {
    func isValid(for type: EntityType) -> Bool {
        switch type {
        case .character:
            return self is Character
        case .creature:
            return self is Creature
        case .droid:
            return self is Droid
        case .organization:
            return self is Organization
        case .planet:
            return self is Planet
        case .species:
            return self is Species
        case .starship:
            return self is Starship
        case .starshipModel:
            return self is StarshipModel
        case .varia:
            return self is Varia
        case .arc:
            return self is Arc
        case .serie:
            return self is Serie
        case .artist:
            return self is Artist
        case .author:
            return self is Artist
        }
    }
}

extension EntityType {
    static var sourceTypes: [EntityType] {
        [.character, .species, .planet, .organization, .starship, .starshipModel, .creature, .droid, .varia]
    }
    
    var displayName: String {
        switch self {
        case .character:
            return "Characters"
        case .creature:
            return "Creatures"
        case .droid:
            return "Droids"
        case .organization:
            return "Organizations"
        case .planet:
            return "Planets"
        case .species:
            return "Species"
        case .starship:
            return "Starships"
        case .starshipModel:
            return "Starship Models"
        case .varia:
            return "Varias"
        case .arc:
            return "Arcs"
        case .serie:
            return "Series"
        case .artist:
            return "Artists"
        case .author:
            return "Authors"
        }
    }
}
