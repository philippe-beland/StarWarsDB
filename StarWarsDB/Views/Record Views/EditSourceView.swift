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
}

struct EditSourceView: View {
    @Bindable var source: Source
    
    @State private var sourceCharacters = [SourceCharacter]()
    @State private var sourceCreatures = [SourceCreature]()
    @State private var sourceDroids = [SourceDroid]()
    @State private var sourceOrganizations = [SourceOrganization]()
    @State private var sourcePlanets = [SourcePlanet]()
    @State private var sourceSpecies = [SourceSpecies]()
    @State private var sourceStarships = [SourceStarship]()
    @State private var sourceStarshipModels = [SourceStarshipModel]()
    @State private var sourceVarias = [SourceVaria]()
    
    private var sortedCharacters: [SourceCharacter] {
        sourceCharacters.sorted(by: { $0.entity.name < $1.entity.name })
    }
    private var sortedCreatures: [SourceCreature] {
        sourceCreatures.sorted(by: { $0.entity.name < $1.entity.name })
    }
    private var sortedDroids: [SourceDroid] {
        sourceDroids.sorted(by: { $0.entity.name < $1.entity.name })
    }
    private var sortedOrganizations: [SourceOrganization] {
        sourceOrganizations.sorted(by: { $0.entity.name < $1.entity.name })
    }
    private var sortedPlanets: [SourcePlanet] {
        sourcePlanets.sorted(by: { $0.entity.name < $1.entity.name })
    }
    private var sortedSpecies: [SourceSpecies] {
        sourceSpecies.sorted(by: { $0.entity.name < $1.entity.name })
    }
    private var sortedStarships: [SourceStarship] {
        sourceStarships.sorted(by: { $0.entity.name < $1.entity.name })
    }
    private var sortedStarshipModels: [SourceStarshipModel] {
        sourceStarshipModels.sorted(by: { $0.entity.name < $1.entity.name })
    }
    private var sortedVarias: [SourceVaria] {
        sourceVarias.sorted(by: { $0.entity.name < $1.entity.name })
    }
    
    let layout = [GridItem(.adaptive(minimum: 200, maximum: 300))]
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(name: source.name, urlString: source.url)
                HStack {
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
                
                CommentsView(comments: source.comments)
                
                Text("Appearances")
                    .bold()
                    .padding()
                    
                Form {
                    Section(header: headerWithButton(title: "Characters", action: {})) {
                        ScrollAppearancesView(sourceItems: sortedCharacters, entityType: .character)
                    }
                    Section(header: headerWithButton(title: "Species", action: {})) {
                        ScrollAppearancesView(sourceItems: sortedSpecies, entityType: .species)
                    }
                    Section(header: headerWithButton(title: "Planets", action: {}))  {
                        ScrollAppearancesView(sourceItems: sortedPlanets, entityType: .planet)
                    }
                    Section(header: headerWithButton(title: "Organizations", action: {})) {
                        ScrollAppearancesView(sourceItems: sortedOrganizations, entityType: .organization)
                    }
                    Section(header: headerWithButton(title: "Starships", action: {}))  {
                        ScrollAppearancesView(sourceItems: sortedStarships, entityType: .starship)
                    }
                    Section(header: headerWithButton(title: "Creatures", action: {}))  {
                        ScrollAppearancesView(sourceItems: sortedCreatures, entityType: .creature)
                    }
                    Section(header: headerWithButton(title: "Droids", action: {})) {
                        ScrollAppearancesView(sourceItems: sortedDroids, entityType: .droid)
                    }
                    Section(header: headerWithButton(title: "Starship Models", action: {})) {
                        ScrollAppearancesView(sourceItems: sortedStarshipModels, entityType: .starshipModel)
                    }
                    Section(header: headerWithButton(title: "Varias", action: {})) {
                        ScrollAppearancesView(sourceItems: sortedVarias, entityType: .varia)
                    }
                }
            }
        }
        .task { await loadInitialSources() }
    }
    
    private struct InfoSection: Identifiable {
        let id = UUID()
        let fieldName: String
        let view: AnyView
    }
    
    private func headerWithButton(title: String, action: @escaping () -> Void) -> some View {
        HStack {
            Text(title)
                .font(.subheadline)
            Spacer()
            Button(action: action) {
                Image(systemName: "plus")
                    .foregroundColor(.blue)
            }
            .buttonStyle(BorderlessButtonStyle()) // Ensures the button doesn't affect other interactions
        }
        .padding(.vertical, 4) // Adjust padding if needed
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
    }
    
    private var infosSection: [InfoSection] {
        var sections: [InfoSection] = [
            InfoSection(fieldName: "Serie", view: AnyView(Text("\(source.serie?.name ?? ""): \(source.number?.description ?? "")"))),
            //InfoSection(fieldName: "Number", view: AnyView(FieldVStack(fieldName: "Number", info: source.number?.description ?? ""))),
            //InfoSection(fieldName: "Arc", view: AnyView(FieldVStack(fieldName: "Arc", info: source.arc?.name ?? ""))),
            //InfoSection(fieldName: "Era", view: AnyView(FieldVStack(fieldName: "Era", info: source.era.rawValue))),
            //InfoSection(fieldName: "Source Type", view: AnyView(FieldVStack(fieldName: "Source Type", info: source.sourceType.rawValue))),
            //InfoSection(fieldName: "Authors", view: AnyView(MultiFieldVStack(fieldName: "Authors", infos: source.authors))),
            //InfoSection(fieldName: "Artists", view: AnyView(MultiFieldVStack(fieldName: "Artists", infos: source.artists))),
            //InfoSection(fieldName: "Number Pages", view: AnyView(FieldVStack(fieldName: "Number Pages", info: source.numberPages?.description ?? ""))),
        ]
        
//        if let year = source.universeYear {
//            sections.append(
//                InfoSection(
//                    fieldName: "In-Universe Year",
//                    //view: AnyView(FieldVStack(fieldName: "In-Universe Year", info: "\(abs(year)) \(year > 0 ? "ABY" : "BBY")"))
//                )
//            )
//        }
        
        return sections
    }
}

#Preview {
    EditSourceView(source: .example)
}
