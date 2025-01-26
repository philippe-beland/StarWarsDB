//
//  EditSourceView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

enum RecordType: String, CaseIterable {
    case characters = "Characters"
    case creatures = "Creatures"
    case droids = "Droids"
    case organizations = "Organizations"
    case planets = "Planets"
    case species = "Species"
    case starships = "Starships"
    case starshipModels = "Starship Models"
    case varias = "Varias"
}

struct EditSourceView: View {
    @Bindable var source: Source
    
    @State private var showFactSheet = false
    
    @State private var sourceCharacters = [SourceCharacter]()
    @State private var sourceCreatures = [SourceCreature]()
    @State private var sourceDroids = [SourceDroid]()
    @State private var sourceOrganizations = [SourceOrganization]()
    @State private var sourcePlanets = [SourcePlanet]()
    @State private var sourceSpecies = [SourceSpecies]()
    @State private var sourceStarships = [SourceStarship]()
    @State private var sourceStarshipModels = [SourceStarshipModel]()
    @State private var sourceVarias = [SourceVaria]()
    @State private var sourceArtists = [SourceArtist]()
    @State private var sourceAuthors = [SourceAuthor]()
    
    private var sortedArtists: [SourceArtist] {
        sourceArtists.sorted (by: { $0.entity.name < $1.entity.name })
    }
    
    private var sortedAuthors: [SourceAuthor] {
        sourceAuthors.sorted(by: { $0.entity.name < $1.entity.name })
    }
    
    @State private var selectedEntityType: EntityType?
    @State private var isEntitySheetPresented = false
    @State private var isExpandedViewPresented = false
    @State private var expandedEntityType: EntityType?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Spacer()
                    HeaderView(name: $source.name, urlString: source.url)
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
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(infosSection) { info in
                            info.view
                                .font(.caption)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding([.horizontal])
                
                Text("Appearances")
                    .bold()
                    .padding()
                
                Form {
                    Section(header: headerWithButton(title: "Characters", entityType: .character)) {
                        ScrollAppearancesView(sourceItems: $sourceCharacters, entityType: .character)
                    }
                    Section(header: headerWithButton(title: "Species", entityType: .species)) {
                        ScrollAppearancesView(sourceItems: $sourceSpecies, entityType: .species)
                    }
                    Section(header: headerWithButton(title: "Planets", entityType: .planet))  {
                        ScrollAppearancesView(sourceItems: $sourcePlanets, entityType: .planet)
                    }
                    Section(header: headerWithButton(title: "Organizations", entityType: .organization)) {
                        ScrollAppearancesView(sourceItems: $sourceOrganizations, entityType: .organization)
                    }
                    Section(header: headerWithButton(title: "Starships", entityType: .starship))  {
                        ScrollAppearancesView(sourceItems: $sourceStarships, entityType: .starship)
                    }
                    Section(header: headerWithButton(title: "Creatures", entityType: .creature))  {
                        ScrollAppearancesView(sourceItems: $sourceCreatures, entityType: .creature)
                    }
                    Section(header: headerWithButton(title: "Droids", entityType: .droid)) {
                        ScrollAppearancesView(sourceItems: $sourceDroids, entityType: .droid)
                    }
                    Section(header: headerWithButton(title: "Starship Models", entityType: .starshipModel)) {
                        ScrollAppearancesView(sourceItems: $sourceStarshipModels, entityType: .starshipModel)
                    }
                    Section(header: headerWithButton(title: "Varias", entityType: .varia)) {
                        ScrollAppearancesView(sourceItems: $sourceVarias, entityType: .varia)
                    }
                }
            }
            .padding(.vertical)
        }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: source.update)
        }
    }
    
    private struct InfoSection: Identifiable {
        let id = UUID()
        let fieldName: String
        let view: AnyView
    }
    
    enum ActiveSheet: Identifiable {
        case entitySheet(EntityType)
        case expandedSheet(EntityType)

        var id: String {
            switch self {
            case .entitySheet(let type):
                return "entity-\(type)"
            case .expandedSheet(let type):
                return "expanded-\(type)"
            }
        }
    }

    @State private var activeSheet: ActiveSheet? = .entitySheet(.character)
    
    private func headerWithButton(title: String, entityType: EntityType) -> some View {
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
                    activeSheet = .expandedSheet(entityType)
                }
            } label: {
                Text("Expand")
            }
        }
        .sheet(item: $activeSheet) { sheet in
                switch sheet {
                case .entitySheet(let type):
                    ChooseEntityView(entityType: type, isSourceItem: true, serie: source.serie) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            addSourceItem(entityType: type, entity: selectedEntity, appearance: appearance)
                        }
                    }
                case .expandedSheet(let type):
                    ExpandedSourceItemView(sourceItems: getSourceItemsBinding(entityType: type), entityType: type)
                }
            }
        }
    
    private func getSourceItemsBinding(entityType: EntityType) -> Binding<[SourceItem]> {
        switch entityType {
        case .character:
            return Binding(
                get: { sourceCharacters as [SourceItem] },
                set: { newItems in sourceCharacters = newItems.compactMap { $0 as? SourceCharacter } }
            )
        case .droid:
            return Binding(
                get: { sourceDroids as [SourceItem] },
                set: { newItems in sourceDroids = newItems.compactMap { $0 as? SourceDroid } }
            )
        case .creature:
            return Binding(
                get: { sourceCreatures as [SourceItem] },
                set: { newItems in sourceCreatures = newItems.compactMap { $0 as? SourceCreature } }
            )
        case .organization:
            return Binding(
                get: { sourceOrganizations as [SourceItem] },
                set: { newItems in sourceOrganizations = newItems.compactMap { $0 as? SourceOrganization } }
            )
        case .planet:
            return Binding(
                get: { sourcePlanets as [SourceItem] },
                set: { newItems in sourcePlanets = newItems.compactMap { $0 as? SourcePlanet } }
            )
        case .species:
            return Binding(
                get: { sourceSpecies as [SourceItem] },
                set: { newItems in sourceSpecies = newItems.compactMap { $0 as? SourceSpecies } }
            )
        case .starshipModel:
            return Binding(
                get: { sourceStarshipModels as [SourceItem] },
                set: { newItems in sourceStarshipModels = newItems.compactMap { $0 as? SourceStarshipModel } }
            )
        case .starship:
            return Binding(
                get: { sourceStarships as [SourceItem] },
                set: { newItems in sourceStarships = newItems.compactMap { $0 as? SourceStarship } }
            )
        case .varia:
            return Binding(
                get: { sourceVarias as [SourceItem] },
                set: { newItems in sourceVarias = newItems.compactMap { $0 as? SourceVaria } }
            )
        case .arc, .serie, .artist, .author:
            return .constant([]) // Return an empty, immutable Binding for unsupported cases
        }
    }
    
    private func addSourceItem(entityType: EntityType, entity: Entity, appearance: AppearanceType) {
        switch entityType {
        case .character:
            let character = entity as! Character
            
            let newSourceItem = SourceCharacter(
                source: source,
                entity: character,
                appearance: appearance
            )
            
            if !sourceCharacters.contains(newSourceItem) {
                newSourceItem.save()
                sourceCharacters.append(newSourceItem)
            } else {
                print("Already exists for that source")
            }
            
            if let species = character.species {
                if species.name.lowercased() != "droid" && appearance != .mentioned {
                    let newSourceSpecies = SourceSpecies(
                        source: source,
                        entity: species,
                        appearance: appearance
                    )
                    
                    if !sourceSpecies.contains(newSourceSpecies) {
                        newSourceSpecies.save()
                        sourceSpecies.append(newSourceSpecies)
                    }
                }
            }

        case .creature:
            let newSourceItem = SourceCreature(
                source: source,
                entity: entity as! Creature,
                appearance: appearance
            )
            
            if !sourceCreatures.contains(newSourceItem) {
                newSourceItem.save()
                sourceCreatures.append(newSourceItem)
            } else {
                print("Already exists for that source")
            }
        case .droid:
            let newSourceItem = SourceDroid(
                source: source,
                entity: entity as! Droid,
                appearance: appearance
            )
            
            if !sourceDroids.contains(newSourceItem) {
                newSourceItem.save()
                sourceDroids.append(newSourceItem)
            } else {
                print("Already exists for that source")
            }
        case .organization:
            let newSourceItem = SourceOrganization(
                source: source,
                entity: entity as! Organization,
                appearance: appearance
            )
            
            if !sourceOrganizations.contains(newSourceItem) {
                newSourceItem.save()
                sourceOrganizations.append(newSourceItem)
            } else {
                print("Already exists for that source")
            }
        case .planet:
            let newSourceItem = SourcePlanet(
                source: source,
                entity: entity as! Planet,
                appearance: appearance
            )
            
            if !sourcePlanets.contains(newSourceItem) {
                newSourceItem.save()
                sourcePlanets.append(newSourceItem)
            } else {
                print("Already exists for that source")
            }
        case .species:
            let newSourceItem = SourceSpecies(
                source: source,
                entity: entity as! Species,
                appearance: appearance
            )
            
            if !sourceSpecies.contains(newSourceItem) {
                newSourceItem.save()
                sourceSpecies.append(newSourceItem)
            } else {
                print("Already exists for that source")
            }
        case .starship:
            let newSourceItem = SourceStarship(
                source: source,
                entity: entity as! Starship,
                appearance: appearance
            )
            
            if !sourceStarships.contains(newSourceItem) {
                newSourceItem.save()
                sourceStarships.append(newSourceItem)
            } else {
                print("Already exists for that source")
            }
        case .starshipModel:
            let newSourceItem = SourceStarshipModel(
                source: source,
                entity: entity as! StarshipModel,
                appearance: appearance
            )
            
            if !sourceStarshipModels.contains(newSourceItem) {
                newSourceItem.save()
                sourceStarshipModels.append(newSourceItem)
            } else {
                print("Already exists for that source")
            }
        case .varia:
            let newSourceItem = SourceVaria(
                source: source,
                entity: entity as! Varia,
                appearance: appearance
            )
            
            if !sourceVarias.contains(newSourceItem) {
                newSourceItem.save()
                sourceVarias.append(newSourceItem)
            } else {
                print("Already exists for that source")
            }
        case .arc:
            print("arc")
        case .serie:
            print("Serie")
        case .artist:
            print("Artist")
        case .author:
            print("Authors")
        }
    }
    
    private func loadInitialSources() async {
        sourceCharacters = await loadSourceCharacters(recordField: "source", recordID: source.id)
        sourceCreatures = await loadSourceCreatures(recordField: "source", recordID: source.id)
        sourceDroids = await loadSourceDroids(recordField: "source", recordID: source.id)
        sourceOrganizations = await loadSourceOrganizations(recordField: "source", recordID: source.id)
        sourcePlanets = await loadSourcePlanets(recordField: "source", recordID: source.id)
        sourceSpecies = await loadSourceSpecies(recordField: "source", recordID: source.id)
        sourceStarships = await loadSourceStarships(recordField: "source", recordID: source.id)
        sourceStarshipModels = await loadSourceStarshipModels(recordField: "source", recordID: source.id)
        sourceVarias = await loadSourceVarias(recordField: "source", recordID: source.id)
        sourceAuthors = await loadSourceAuthors(recordField: "source", recordID: source.id)
        sourceArtists = await loadSourceArtists(recordField: "source", recordID: source.id)
    }
    
    private var infosSection: [InfoSection] {
        let sections: [InfoSection] = [
            InfoSection(fieldName: "Serie", view: AnyView(EditVEntityInfoView(
                fieldName: "Serie",
                entity: Binding(
                    get: {source.serie ?? Serie.empty },
                    set: {source.serie = ($0 as! Serie) }),
                entityType: .serie))),
            InfoSection(fieldName: "Arc", view: AnyView(EditVEntityInfoView(
                fieldName: "Arc",
                entity: Binding(
                    get: {source.arc ?? Arc.empty },
                    set: {source.arc = ($0 as! Arc) }),
                entityType: .arc))),
            InfoSection(fieldName: "Number", view: AnyView(TextField("Number", value: $source.number, format: .number))),
            InfoSection(fieldName: "Era", view: AnyView(EraPicker(era: $source.era))),
            InfoSection(fieldName: "Type", view: AnyView(SourceTypePicker(sourceType: $source.sourceType))),
            InfoSection(fieldName: "Publication Date", view: AnyView(PublicationDatePicker(date: $source.publicationDate))),
            InfoSection(fieldName: "In-Universe Year", view: AnyView(YearPicker(era: source.era, universeYear: $source.universeYear))),
            InfoSection(fieldName: "Authors", view: AnyView(AuthorsVStack(source: source, authors: sortedAuthors))),
            InfoSection(fieldName: "Artists", view: AnyView(ArtistsVStack(source: source, artists: sortedArtists))),
            InfoSection(fieldName: "Number Pages", view: AnyView(TextField("Nb of pages", value: $source.numberPages, format: .number)))
        ]
        
        return sections
    }
}

struct ExpandedSourceItemView: View {
    @Binding var sourceItems: [SourceItem]
    var entityType: EntityType
    
    private var sortedEntities: [SourceItem] {
        sourceItems.sorted(by: { $0.entity.name < $1.entity.name })
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedEntities) { sourceItem in
                    RecordEntryView(
                        name: sourceItem.entity.name ,
                        imageName: sourceItem.entity.id,
                        appearance: sourceItem.appearance)
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
             Button(AppearanceType.present.description) { updateAppearance(of: sourceItem, to: .present) }
             Button(AppearanceType.mentioned.description) { updateAppearance(of: sourceItem, to: .mentioned) }
             Button(AppearanceType.flashback.description) { updateAppearance(of: sourceItem, to: .flashback) }
             Button(AppearanceType.vision.description) { updateAppearance(of: sourceItem, to: .vision) }
             Button(AppearanceType.image.description) { updateAppearance(of: sourceItem, to: .image)}
             Button(AppearanceType.indirectMentioned.description) { updateAppearance(of: sourceItem, to: .indirectMentioned)}
         }
     }
    
    private func updateAppearance(of sourceItem: SourceItem, to appearance: AppearanceType) {
        if let index = sourceItems.firstIndex(where: { $0.id == sourceItem.id }) {
            sourceItems[index].appearance = appearance
        }
        sourceItem.update()
    }
    
    private func deleteEntity(_ indexSet: IndexSet) {
        for index in indexSet {
            let entity = sortedEntities[index]
            if let indexofSource = sourceItems.firstIndex(of: entity) {
                sourceItems.remove(at: indexofSource)
            }
            entity.delete()
        }
    }
}

//#Preview {
//    EditSourceView(source: .example)
//}
