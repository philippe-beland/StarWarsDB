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
    
    var sourceCharacters: [SourceCharacter] = SourceCharacter.example
    var sourceCreatures: [SourceCreature] = SourceCreature.example
    var sourceDroids: [SourceDroid] = SourceDroid.example
    var sourceOrganizations: [SourceOrganization] = SourceOrganization.example
    var sourcePlanets: [SourcePlanet] = SourcePlanet.example
    var sourceSpecies: [SourceSpecies] = SourceSpecies.example
    var sourceStarships: [SourceStarship] = SourceStarship.example
    var sourceStarshipModels: [SourceStarshipModel] = SourceStarshipModel.example
    
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
                        ScrollAppearancesView(sourceItems: sourceCharacters, entityType: .character)
                    }
                    Section(header: headerWithButton(title: "Species", action: {})) {
                        ScrollAppearancesView(sourceItems: sourceSpecies, entityType: .species)
                    }
                    Section(header: headerWithButton(title: "Planets", action: {}))  {
                        ScrollAppearancesView(sourceItems: sourcePlanets, entityType: .planet)
                    }
                    Section(header: headerWithButton(title: "Organizations", action: {})) {
                        ScrollAppearancesView(sourceItems: sourceOrganizations, entityType: .organization)
                    }
                    Section(header: headerWithButton(title: "Starships", action: {}))  {
                        ScrollAppearancesView(sourceItems: sourceStarships, entityType: .starship)
                    }
                    Section(header: headerWithButton(title: "Creatures", action: {}))  {
                        ScrollAppearancesView(sourceItems: sourceCreatures, entityType: .creature)
                    }
                    Section(header: headerWithButton(title: "Droids", action: {})) {
                        ScrollAppearancesView(sourceItems: sourceDroids, entityType: .droid)
                    }
                    Section(header: headerWithButton(title: "Starship Models", action: {})) {
                        ScrollAppearancesView(sourceItems: sourceStarshipModels, entityType: .starshipModel)
                    }
                }
            }
        }
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
    
    private var infosSection: [InfoSection] {
        var sections: [InfoSection] = [
            InfoSection(fieldName: "Serie", view: AnyView(Text("\(source.serie?.name ?? ""): \(source.number?.description ?? "")"))),
            InfoSection(fieldName: "Number", view: AnyView(FieldVStack(fieldName: "Number", info: source.number?.description ?? ""))),
            InfoSection(fieldName: "Arc", view: AnyView(FieldVStack(fieldName: "Arc", info: source.arc?.name ?? ""))),
            InfoSection(fieldName: "Era", view: AnyView(FieldVStack(fieldName: "Era", info: source.era.rawValue))),
            InfoSection(fieldName: "Source Type", view: AnyView(FieldVStack(fieldName: "Source Type", info: source.sourceType.rawValue))),
            //InfoSection(fieldName: "Authors", view: AnyView(MultiFieldVStack(fieldName: "Authors", infos: source.authors))),
            //InfoSection(fieldName: "Artists", view: AnyView(MultiFieldVStack(fieldName: "Artists", infos: source.artists))),
            InfoSection(fieldName: "Number Pages", view: AnyView(FieldVStack(fieldName: "Number Pages", info: source.numberPages?.description ?? ""))),
        ]
        
        if let year = source.universeYear {
            sections.append(
                InfoSection(
                    fieldName: "In-Universe Year",
                    view: AnyView(FieldVStack(fieldName: "In-Universe Year", info: "\(abs(year)) \(year > 0 ? "ABY" : "BBY")"))
                )
            )
        }
        
        return sections
    }
}

#Preview {
    EditSourceView(source: .example)
}
