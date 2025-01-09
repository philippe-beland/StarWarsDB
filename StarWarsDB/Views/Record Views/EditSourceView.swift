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
    
    @State private var showEntityForSection: [EntityType: Bool] = [:]
    
    let layout = [GridItem(.adaptive(minimum: 200, maximum: 300))]
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(name: source.name, urlString: source.url)
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
                
                LazyVGrid(columns: layout) {
                    ForEach(infosSection) { info in
                        info.view
                            .font(.caption)
                    }
                }
                
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
            .padding()
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
    
    private func headerWithButton(title: String, entityType: EntityType) -> some View {
        HStack {
            Text(title)
                .font(.subheadline)
            Spacer()
            Button(action: {}) {
                Text("Expand")
            }
            Spacer()
            Button(action: {
                showEntityForSection[entityType] = true
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.blue)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .sheet(isPresented: Binding(
            get: { showEntityForSection[entityType] ?? false},
            set: { showEntityForSection[entityType] = $0 }
        )) {
            ChooseEntityView(entityType: entityType, isSourceItem: true) { selectedEntities, appearance in
                for selectedEntity in selectedEntities {
                    addSourceItem(entityType: entityType, entity: selectedEntity, appearance: appearance)
                }
            }
        }
        .padding(.vertical, 4)
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
        }
    }
    
    private func loadInitialSources() async {
        sourceCharacters = await loadSourceCharacters(recordField: "source", recordID: source.id.uuidString)
        sourceCreatures = await loadSourceCreatures(recordField: "source", recordID: source.id.uuidString)
        sourceDroids = await loadSourceDroids(recordField: "source", recordID: source.id.uuidString)
        sourceOrganizations = await loadSourceOrganizations(recordField: "source", recordID: source.id.uuidString)
        sourcePlanets = await loadSourcePlanets(recordField: "source", recordID: source.id.uuidString)
        sourceSpecies = await loadSourceSpecies(recordField: "source", recordID: source.id.uuidString)
        sourceStarships = await loadSourceStarships(recordField: "source", recordID: source.id.uuidString)
        sourceStarshipModels = await loadSourceStarshipModels(recordField: "source", recordID: source.id.uuidString)
        sourceVarias = await loadSourceVarias(recordField: "source", recordID: source.id.uuidString)
        sourceAuthors = await loadSourceAuthors(recordField: "source", recordID: source.id.uuidString)
        sourceArtists = await loadSourceArtists(recordField: "source", recordID: source.id.uuidString)
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
            InfoSection(fieldName: "Era", view: AnyView(EraPicker(era: $source.era))),
            InfoSection(fieldName: "Type", view: AnyView(SourceTypePicker(sourceType: $source.sourceType))),
            InfoSection(fieldName: "In-Universe Year", view: AnyView(YearPicker(era: source.era, universeYear: $source.universeYear))),
            InfoSection(fieldName: "Authors", view: AnyView(ArtistsVStack(fieldName: "Authors", entities: sortedAuthors))),
            InfoSection(fieldName: "Artists", view: AnyView(ArtistsVStack(fieldName: "Artists", entities: sortedArtists))),
            InfoSection(fieldName: "Number Pages", view: AnyView(Text(source.numberPages?.description ?? ""))),
        ]
        
        return sections
    }
}

//#Preview {
//    EditSourceView(source: .example)
//}
